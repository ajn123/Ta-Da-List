# frozen_string_literal: true

class Api::ListsController < Api::ApiController
  before_action :find_list, only: %i[update destroy show]

  def index
    render status: :ok, json: {
      lists: List.all
    }.to_json
  end

  def create
    list = @user.lists.build(list_params)
    if list.save
      ActionCable.server.broadcast 'list_channel',
                                   action: 'CREATE',
                                   list: list.as_json
      render status: :ok, json: { message: 'Successful creation', list: list }
    else
      ActionCable.server.broadcast 'list_channel',
                                   action: 'ERROR',
                                   errors: list.errors.full_messages
      render status: :unprocessable_entity, json: {
        message: list.errors.full_messages.to_s
      }.to_json
    end
  end

  def destroy
    id = @list.id
    ActionCable.server.broadcast 'list_channel',
                                 action: 'DELETE',
                                 id: id
    render status: :ok, json: { message: 'destroyed', list: @list }.to_json
  end

  def update
    if @list.update(list_params)
      render status: :ok, json: {
        message: 'Successfuly updated list', list: @list
      }
    else
      render status: :internal_server_error, json: {
        message: 'Could not update list',
        errors: @list.errors.full_messages.to_s
      }.to_json
    end
  end

  def show
    render status: :ok, json: { list: @list.includes(:items).as_json(include: [:items]) }.to_json
  end

  private

  def list_params
    params.require(:list).permit(:title, items_attributes: %i[completed due_date list_id
                                                              id title content _destroy])
  end

  def find_list
    @list = List.find(params[:id])
  rescue StandardError
    render status: :unprocessable_entity, json: { message:
                              "Could not find id: #{params[:id]}" }
  end
end
