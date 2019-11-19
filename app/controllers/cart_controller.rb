class CartController < ApplicationController
 
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
 
 
 
  def index
      if session[:cart] then
        @cart = session[:cart]
      else
        @cart ={}
      end  
        
  end
end
