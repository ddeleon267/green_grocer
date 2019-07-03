require "pry"
def consolidate_cart(cart)
  consolidated_cart = {}

  cart.each do |item|
    item_name = item.keys.first
    if consolidated_cart[item_name]
      consolidated_cart[item_name][:count] += 1
    else
      consolidated_cart[item_name] = {
        price: item[item_name][:price],
        clearance: item[item_name][:clearance],
        count: 1
      }
    end

  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  # code here
end

def apply_clearance(cart)
  # code here
end

def checkout(cart, coupons)
  # code here
end
