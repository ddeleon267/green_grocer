require "pry"
def consolidate_cart(cart) # if you don't iterate through the item
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

# def consolidate_cart(cart) # if you iterate through the item
#   consolidated_cart = {}
#
#   cart.each do |item|
#     item.each do |name, details|
#       if consolidated_cart[name]
#         consolidated_cart[name][:count] += 1
#       else
#         consolidated_cart[name] = details
#         consolidated_cart[name][:count] = 1
#       end
#     end
#   end
#   consolidated_cart
# end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    if cart[coupon[:item]] && cart[coupon[:item]][:count] >= coupon[:num]
      if cart["#{coupon[:item]} W/COUPON"]
        cart["#{coupon[:item]} W/COUPON"][:count] += coupon[:num]

      else
        cart["#{coupon[:item]} W/COUPON"] = {
          price: coupon[:cost] / coupon[:num],
          clearance: cart[coupon[:item]][:clearance],
          count: coupon[:num]
        }
      end
      cart[coupon[:item]][:count] -= coupon[:num]
    end
  end
  cart
end

def apply_clearance(cart)
  cart.each do |item_name, values|
    if values[:clearance]
      values[:price] = (values[:price] * 0.8).round(2)
    end
  end
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)

  total = 0
  final_cart.each do |item_name, details|
    total += details[:price]*details[:count]
  end
  total
end
