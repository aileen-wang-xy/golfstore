class CartController < ApplicationController
 before_action :authenticate_user!
 def add
    # get an id of a product
    id = params[:id]
    
    # if the cart is already been created , use the exisiting one else create a blank cart
    if session[:cart] then
        cart= session[:cart]
    else
        session[:cart]={}
        cart= session[:cart]
    end   
    
    # if product us already added increment it by one else set it to 1
    if cart[id] then
        cart[id]+=1
    else
        cart[id]=1
    end  
    
    redirect_to :action=> :index
 end   
 
 def remove
     id =params[:id]
     cart = session[:cart]
     cart.delete id
     
     redirect_to :action => :index
     
 end     
     
 def decrease
    id = params[:id] 
     cart = session[:cart]
     if cart[id]==1 then
         cart.delete id
     else
         cart[id]= cart[id]-1
    end
    redirect_to :action => :index
  end     
 
 
  def clearCart
    # sets session variable to nil and bring back to index
    session[:cart] = nil
    redirect_to :action => :index
  end
 
 
  def index
      if session[:cart] then
        @cart = session[:cart]
      else
        @cart ={}
      end  
  end
  
  def createOrder
     # Step 1: Get the current user
     @user = User.find(current_user.id)
    
     # Step 2: Create a new order and associate it with the current user
     @order = @user.orders.build(:order_date => DateTime.now, :status => 'Pending')
     @order.save
    
     # Step 3: For each item in the cart, create a new item on the order!!
     @cart = session[:cart] || {} # Get the content of the Cart
     @cart.each do | id, quantity |
         item = Item.find_by_id(id)
         @orderitem = @order.orderitems.build(:item_id => item.id, :title => item.title, :description => item.description, :quantity => quantity, :price=> item.price)
         @orderitem.save
     end
     @orders = Order.all
  end

  
  
  
end
