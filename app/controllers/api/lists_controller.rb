# frozen_string_literal: true

class Api::ListsController < Api::ApiController
  before_action :find_list, only: %i[update destroy show]

  def index
    render status: :ok, json: {
      lists: List.all.as_json(include: [:items])
    }.to_json
  end

  def create
    list = List.new(list_params)
    Action.server.broadcast 'list_channel',
                            title: list.title
    if list.save
      render status: :ok, json: { message: 'Successful creation', list: list }
    else
      render status: :unprocessable_entity, json: {
        message: list.errors
      }.to_json
    end
  end

  def destroy
    render :no_content unless @list.destroy
    render status: :ok, json: { message: "#{@list.inspect} destroyed" }
  end

  def update
    if @list.update(list_params)
      render status: :ok, json: {
        message: 'Successfuly updated list', list: @list
      }
    else
      render status: :internal_server_error, json: {
        message: 'Could not update list'
      }
    end
  end

  def show
    render status: :ok, json: { list: @list.as_json(include: [:items]) }.to_json
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end

  def find_list
    @list = List.find(params[:id])
  rescue Exception
    render status: :unprocessable_entity, json: { message: "Could not find id: #{params[:id]}" }
  end
end
