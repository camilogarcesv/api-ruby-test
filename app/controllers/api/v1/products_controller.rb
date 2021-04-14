class Api::V1::ProductsController < ApplicationController
  def index
    products = Product.all
    render json: products, status: 200
  end
  # Como el nombre implica esta acción, se crea un nuevo producto
  # Si el producto se guarda correctamente, se renderiza el json para el producto
  # Si el producto no se guarda correctamente, se renderiza un objeto de error
  def create
    product = Product.new(
      name: prod_params[:name],
      brand: prod_params[:brand],
      price: prod_params[:price],
      description: prod_params[:description],
    )
    if product.save
      render json: product, status: 200
    else 
      render json: {error: "Error creando el producto."}
    end
  end

  # Este metodo busca el producto por id, si es encontrado se renderiza el json
  # De no ser así, se renderiza un objeto de error
  def show
    product = Product.find_by(id: params[:id])
    if product
      render json: product, status: 200
    else
      render json: {error: "Producto no encontrado."}
    end
  end

  #Este método privado solamente está diponible en este controlador
  # Utiliza métodos internos .require y .permit que provee el ActionController
  private
    def prod_params
      params.require(:product).permit([
        :name,
        :brand,
        :price,
        :description
      ])
    end
end
