class Api::ListsController < Api::ApiController


  def index
    render status: :ok, json: { lists: List.all }.to_json
  end

  def create
    list = List.new(list_params)
    if list.save
      render status: :ok, json: {message: "Successful creation", list: list}
    else
      render status: :unprocessable_entity, json: { message: list.errors }.to_json
    end
  end

  def destroy
    list = List.find(params[:id])
    if list.destroy
      render status: :ok, json: {message: "#{list.inspect} destroyed"}
    end
  end

  def list_params
    params.require(:list).permit(:title)
  end
end
