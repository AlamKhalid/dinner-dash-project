# frozen_string_literal: true

# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

# Restaurants seed
# Restaurant.destroy_all
ranchers = Restaurant.create(name: 'Ranchers', location: 'Islamabad')
kfc = Restaurant.create(name: 'KFC', location: 'Islamabad')
pizza_hut = Restaurant.create(name: 'Pizza Hut', location: 'Islamabad')

# Category seed
# Category.destroy_all
Category.create(name: 'Fast Food')
Category.create(name: 'Pakistani')
Category.create(name: 'Chinese')
Category.create(name: 'Continental')
Category.create(name: 'Italian')
Category.create(name: 'Mexican')

# get all categories
all_categories = Category.all

# User seed
u1 = User.create(full_name: 'Rachel Warbelow', email: 'demo+rachel@jumpstartlab.com', password: 'password')
u2 = User.create(full_name: 'Jeff Casimir', email: 'demo+jeff@jumpstartlab.com', password: 'password',
                 display_name: 'j3')
u3 = User.create(full_name: 'Jorge Tellez', email: 'demo+jorge@jumpstartlab.com', password: 'password',
                 display_name: 'novohispano')
u4 = User.create(full_name: 'Josh Cheek', email: 'demo+josh@jumpstartlab.com', password: 'password', display_name: 'josh',
                 role: 1)

# Item seed
# Item.destroy_all
# Rancher Items
# item-1
i1 = Item.new(name: 'Krunch Burger',
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                          Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              price: 200.0,
              restaurant_id: ranchers.id)
i1.item_picture.attach(io: File.open('./app/assets/images/ranchers/krunch.png'), filename: 'krunch-ranchers.png')
i1.categories << all_categories[0]
i1.categories << all_categories[4]
i1.save
# item-2
i2 = Item.new(name: 'Frizza',
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                            Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              price: 300.0,
              restaurant_id: ranchers.id)
i2.item_picture.attach(io: File.open('./app/assets/images/ranchers/frizza.png'), filename: 'frizza-ranchers.png')
i2.categories << all_categories[0]
i2.categories << all_categories[3]
i2.save
# item-3
i3 = Item.new(name: 'Rodeo',
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
             Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              price: 600.0,
              restaurant_id: ranchers.id)
i3.item_picture.attach(io: File.open('./app/assets/images/ranchers/rodeo.png'), filename: 'rodeo-ranchers.png')
i3.categories << all_categories[2]
i3.categories << all_categories[1]
i3.save
# item-4
i4 = Item.new(name: 'Bronco',
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
             Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              price: 600.0,
              restaurant_id: ranchers.id)
i4.item_picture.attach(io: File.open('./app/assets/images/ranchers/bronco.png'), filename: 'bronco-ranchers.png')
i4.categories << all_categories[4]
i4.categories << all_categories[5]
i4.save
# item-5
i5 = Item.new(name: 'Big Ben',
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
             Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              price: 600.0,
              restaurant_id: ranchers.id)
i5.item_picture.attach(io: File.open('./app/assets/images/ranchers/big_ben.png'), filename: 'big-ben-ranchers.png')
i5.categories << all_categories[1]
i5.categories << all_categories[3]
i5.save
# item-6
i6 = Item.new(name: 'Pablito',
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
             Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              price: 500.0,
              restaurant_id: ranchers.id)
i6.item_picture.attach(io: File.open('./app/assets/images/ranchers/pablito.png'), filename: 'pablito-ranchers.png')
i6.categories << all_categories[1]
i6.categories << all_categories[2]
i6.save
# item-7
i7 = Item.new(name: 'Fajita',
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
             Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              price: 600.0,
              restaurant_id: ranchers.id)
i7.item_picture.attach(io: File.open('./app/assets/images/ranchers/fajita.png'), filename: 'fajita-ranchers.png')
i7.categories << all_categories[2]
i7.categories << all_categories[5]
i7.save

# KFC Items
# item-1
i8 = Item.new(name: 'Zinger Burger',
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              price: 210.0,
              restaurant_id: kfc.id)
i8.item_picture.attach(io: File.open('./app/assets/images/kfc/zinger.png'), filename: 'krunch-kfc.png')
i8.categories << all_categories[0]
i8.categories << all_categories[5]
i8.save
# item-2
i9 = Item.new(name: 'Mighty Zinger',
              description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
              price: 610.0,
              restaurant_id: kfc.id)
i9.item_picture.attach(io: File.open('./app/assets/images/kfc/mighty_zinger.png'), filename: 'mighty-zinger-kfc.png')
i9.categories << all_categories[5]
i9.categories << all_categories[3]
i9.save
# item-3
i10 = Item.new(name: 'Zinger Stacker',
               description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
               price: 510.0,
               restaurant_id: kfc.id)
i10.item_picture.attach(io: File.open('./app/assets/images/kfc/zinger_stacker.png'), filename: 'zinger-stacker-kfc.png')
i10.categories << all_categories[0]
i10.categories << all_categories[2]
i10.save
# item-4
i11 = Item.new(name: 'Twister',
               description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
               price: 310.0,
               restaurant_id: kfc.id)
i11.item_picture.attach(io: File.open('./app/assets/images/kfc/twister.png'), filename: 'twister-kfc.png')
i11.categories << all_categories[0]
i11.categories << all_categories[1]
i11.save
# item-5
i12 = Item.new(name: 'Fries',
               description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
               price: 210.0,
               restaurant_id: kfc.id)
i12.item_picture.attach(io: File.open('./app/assets/images/kfc/fries.png'), filename: 'fries-kfc.png')
i12.categories << all_categories[1]
i12.categories << all_categories[2]
i12.save
# item-6
i13 = Item.new(name: 'Nuggets',
               description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                  Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
               price: 250.0,
               restaurant_id: kfc.id)
i13.item_picture.attach(io: File.open('./app/assets/images/kfc/nuggets.jpeg'), filename: 'nuggets-kfc.jpeg')
i13.categories << all_categories[2]
i13.categories << all_categories[4]
i13.save

# Pizza Hut Items
# item-1
i14 = Item.new(name: 'Chicken Tikka',
               description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
               price: 299.0,
               restaurant_id: pizza_hut.id)
i14.item_picture.attach(io: File.open('./app/assets/images/pizza_hut/tikka.jpeg'), filename: 'tikka-pizza-hut.jpeg')
i14.categories << all_categories[0]
i14.categories << all_categories[4]
i14.save

# item-2
i15 = Item.new(name: 'Chicken Fajita',
               description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
               price: 299.0,
               restaurant_id: pizza_hut.id)
i15.item_picture.attach(io: File.open('./app/assets/images/pizza_hut/fajita.jpeg'), filename: 'fajita-pizza-hut.jpeg')
i15.categories << all_categories[0]
i15.categories << all_categories[2]
i15.save
# item-3
i16 = Item.new(name: 'Veggie',
               description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
               price: 299.0,
               restaurant_id: pizza_hut.id)
i16.item_picture.attach(io: File.open('./app/assets/images/pizza_hut/veggie.jpeg'), filename: 'veggie-pizza-hut.jpeg')
i16.categories << all_categories[0]
i16.categories << all_categories[2]
i16.save

# item-4
i17 = Item.new(name: 'Margherita Pizza',
               description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
               price: 299.0,
               restaurant_id: pizza_hut.id)
i17.item_picture.attach(io: File.open('./app/assets/images/pizza_hut/margherita.jpeg'),
                        filename: 'margherita-pizza-hut.jpeg')
i17.categories << all_categories[5]
i17.categories << all_categories[4]
i17.save
# item-5
i18 = Item.new(name: 'Creamy Melt',
               description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
               price: 299.0,
               restaurant_id: pizza_hut.id)
i18.item_picture.attach(io: File.open('./app/assets/images/pizza_hut/creamy_melt.jpeg'),
                        filename: 'creamy-melt-pizza-hut.jpeg')
i18.categories << all_categories[3]
i18.categories << all_categories[1]
i18.save
# item-6
i19 = Item.new(name: 'Garlic Bread',
               description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
               price: 199.0,
               restaurant_id: pizza_hut.id)
i19.item_picture.attach(io: File.open('./app/assets/images/pizza_hut/garlic_bread.jpeg'),
                        filename: 'garlic-bread-pizza-hut.jpeg')
i19.categories << all_categories[0]
i19.categories << all_categories[4]
i19.save
# item-7
i20 = Item.new(name: 'Brownie',
               description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
               price: 199.0,
               restaurant_id: pizza_hut.id)
i20.item_picture.attach(io: File.open('./app/assets/images/pizza_hut/brownie.jpeg'), filename: 'brownie-pizza-hut.jpeg')
i20.categories << all_categories[2]
i20.categories << all_categories[1]
i20.save

# Order creation
# order-1
o = Order.create(user_id: u1.id, status: 0, total_price: 700, restaurant_id: ranchers.id)
OrderItem.create(cart_order_id: o.id, item_id: i1.id, quantity: 2)
OrderItem.create(cart_order_id: o.id, item_id: i2.id, quantity: 1)
# order-2
o = Order.create(user_id: u1.id, status: 1, total_price: 2400, restaurant_id: ranchers.id)
OrderItem.create(cart_order_id: o.id, item_id: i3.id, quantity: 2)
OrderItem.create(cart_order_id: o.id, item_id: i4.id, quantity: 2)
# order-3
o = Order.create(user_id: u2.id, status: 2, total_price: 2700, restaurant_id: ranchers.id)
OrderItem.create(cart_order_id: o.id, item_id: i5.id, quantity: 2)
OrderItem.create(cart_order_id: o.id, item_id: i6.id, quantity: 1)
OrderItem.create(cart_order_id: o.id, item_id: i1.id, quantity: 5)
# order-4
o = Order.create(user_id: u2.id, status: 3, total_price: 300, restaurant_id: ranchers.id)
OrderItem.create(cart_order_id: o.id, item_id: i2.id, quantity: 1)
# order-5
o = Order.create(user_id: u3.id, status: 0, total_price: 610, restaurant_id: kfc.id)
OrderItem.create(cart_order_id: o.id, item_id: i9.id, quantity: 1)
# order-6
o = Order.create(user_id: u3.id, status: 0, total_price: 500, restaurant_id: kfc.id)
OrderItem.create(cart_order_id: o.id, item_id: i13.id, quantity: 2)
# order-7
o = Order.create(user_id: u4.id, status: 1, total_price: 1340, restaurant_id: kfc.id)
OrderItem.create(cart_order_id: o.id, item_id: i9.id, quantity: 1)
OrderItem.create(cart_order_id: o.id, item_id: i11.id, quantity: 1)
OrderItem.create(cart_order_id: o.id, item_id: i12.id, quantity: 2)
# order-8
o = Order.create(user_id: u4.id, status: 2, total_price: 299, restaurant_id: pizza_hut.id)
OrderItem.create(cart_order_id: o.id, item_id: i14.id, quantity: 1)
# order-9
o = Order.create(user_id: u4.id, status: 3, total_price: 1395, restaurant_id: pizza_hut.id)
OrderItem.create(cart_order_id: o.id, item_id: i14.id, quantity: 4)
OrderItem.create(cart_order_id: o.id, item_id: i20.id, quantity: 1)
# order-10
o = Order.create(user_id: u4.id, status: 3, total_price: 199, restaurant_id: pizza_hut.id)
OrderItem.create(cart_order_id: o.id, item_id: i19.id, quantity: 1)
