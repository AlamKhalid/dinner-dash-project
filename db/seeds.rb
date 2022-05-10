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
User.create(full_name: 'Rachel Warbelow', email: 'demo+rachel@jumpstartlab.com', password: 'password')
User.create(full_name: 'Jeff Casimir', email: 'demo+jeff@jumpstartlab.com', password: 'password', display_name: 'j3')
User.create(full_name: 'Jorge Tellez', email: 'demo+jorge@jumpstartlab.com', password: 'password',
            display_name: 'novohispano')
User.create(full_name: 'Josh Cheek', email: 'demo+josh@jumpstartlab.com', password: 'password', display_name: 'josh',
            role: 1)

# Item seed
# Item.destroy_all
# Rancher Items
# item-1
i = Item.new(name: 'Krunch Burger',
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                          Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                 price: 200.0,
                 restaurant_id: ranchers.id)
i.item_picture.attach(io: File.open('./app/assets/images/ranchers/krunch.png'), filename: 'krunch-ranchers.png')
i.categories << all_categories[0]
i.categories << all_categories[4]
i.save
# item-2
i = Item.new(name: 'Frizza',
                description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                            Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                price: 300.0,
                restaurant_id: ranchers.id)
i.item_picture.attach(io: File.open('./app/assets/images/ranchers/frizza.png'), filename: 'frizza-ranchers.png')
i.categories << all_categories[0]
i.categories << all_categories[3]
i.save
# item-3
i = Item.new(name: 'Rodeo',
                description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
             Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                price: 600.0,
                restaurant_id: ranchers.id)
i.item_picture.attach(io: File.open('./app/assets/images/ranchers/rodeo.png'), filename: 'rodeo-ranchers.png')
i.categories << all_categories[2]
i.categories << all_categories[1]
i.save
# item-4
i = Item.new(name: 'Bronco',
                description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
             Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                price: 600.0,
                restaurant_id: ranchers.id)
i.item_picture.attach(io: File.open('./app/assets/images/ranchers/bronco.png'), filename: 'bronco-ranchers.png')
i.categories << all_categories[4]
i.categories << all_categories[5]
i.save
# item-5
i = Item.new(name: 'Big Ben',
                description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
             Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                price: 600.0,
                restaurant_id: ranchers.id)
i.item_picture.attach(io: File.open('./app/assets/images/ranchers/big_ben.png'), filename: 'big-ben-ranchers.png')
i.categories << all_categories[1]
i.categories << all_categories[3]
i.save
# item-6
i = Item.new(name: 'Pablito',
                description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
             Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                price: 500.0,
                restaurant_id: ranchers.id)
i.item_picture.attach(io: File.open('./app/assets/images/ranchers/pablito.png'), filename: 'pablito-ranchers.png')
i.categories << all_categories[1]
i.categories << all_categories[2]
i.save
# item-7
i = Item.new(name: 'Fajita',
                description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
             Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                price: 600.0,
                restaurant_id: ranchers.id)
i.item_picture.attach(io: File.open('./app/assets/images/ranchers/fajita.png'), filename: 'fajita-ranchers.png')
i.categories << all_categories[2]
i.categories << all_categories[5]
i.save

# KFC Items
# item-1
i = Item.new(name: 'Zinger Burger',
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                 price: 210.0,
                 restaurant_id: kfc.id)
i.item_picture.attach(io: File.open('./app/assets/images/kfc/zinger.png'), filename: 'krunch-kfc.png')
i.categories << all_categories[0]
i.categories << all_categories[5]
i.save
# item-2
i = Item.new(name: 'Mighty Zinger',
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                 price: 610.0,
                 restaurant_id: kfc.id)
i.item_picture.attach(io: File.open('./app/assets/images/kfc/mighty_zinger.png'), filename: 'mighty-zinger-kfc.png')
i.categories << all_categories[5]
i.categories << all_categories[3]
i.save
# item-3
i = Item.new(name: 'Zinger Stacker',
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                 price: 510.0,
                 restaurant_id: kfc.id)
i.item_picture.attach(io: File.open('./app/assets/images/kfc/zinger_stacker.png'), filename: 'zinger-stacker-kfc.png')
i.categories << all_categories[0]
i.categories << all_categories[2]
i.save
# item-4
i = Item.new(name: 'Twister',
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                 price: 310.0,
                 restaurant_id: kfc.id)
i.item_picture.attach(io: File.open('./app/assets/images/kfc/twister.png'), filename: 'twister-kfc.png')
i.categories << all_categories[0]
i.categories << all_categories[1]
i.save
# item-5
i = Item.new(name: 'Fries',
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                 price: 210.0,
                 restaurant_id: kfc.id)
i.item_picture.attach(io: File.open('./app/assets/images/kfc/fries.png'), filename: 'fries-kfc.png')
i.categories << all_categories[1]
i.categories << all_categories[2]
i.save
# item-6
i = Item.new(name: 'Nuggets',
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
                  Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                 price: 250.0,
                 restaurant_id: kfc.id)
i.item_picture.attach(io: File.open('./app/assets/images/kfc/nuggets.jpeg'), filename: 'nuggets-kfc.jpeg')
i.categories << all_categories[2]
i.categories << all_categories[4]
i.save

# Pizza Hut Items
# item-1
i = Item.new(name: 'Chicken Tikka',
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                 price: 299.0,
                 restaurant_id: pizza_hut.id)
i.item_picture.attach(io: File.open('./app/assets/images/pizza_hut/tikka.jpeg'), filename: 'tikka-pizza-hut.jpeg')
i.categories << all_categories[0]
i.categories << all_categories[4]
i.save

# item-2
i = Item.new(name: 'Chicken Fajita',
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                 price: 299.0,
                 restaurant_id: pizza_hut.id)
i.item_picture.attach(io: File.open('./app/assets/images/pizza_hut/fajita.jpeg'), filename: 'fajita-pizza-hut.jpeg')
i.categories << all_categories[0]
i.categories << all_categories[2]
i.save
# item-3
i = Item.new(name: 'Veggie',
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                 price: 299.0,
                 restaurant_id: pizza_hut.id)
i.item_picture.attach(io: File.open('./app/assets/images/pizza_hut/veggie.jpeg'), filename: 'veggie-pizza-hut.jpeg')
i.categories << all_categories[0]
i.categories << all_categories[2]
i.save

# item-4
i = Item.new(name: 'Margherita Pizza',
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                 price: 299.0,
                 restaurant_id: pizza_hut.id)
i.item_picture.attach(io: File.open('./app/assets/images/pizza_hut/margherita.jpeg'),
                      filename: 'margherita-pizza-hut.jpeg')
i.categories << all_categories[5]
i.categories << all_categories[4]
i.save
# item-5
i = Item.new(name: 'Creamy Melt',
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                 price: 299.0,
                 restaurant_id: pizza_hut.id)
i.item_picture.attach(io: File.open('./app/assets/images/pizza_hut/creamy_melt.jpeg'),
                      filename: 'creamy-melt-pizza-hut.jpeg')
i.categories << all_categories[3]
i.categories << all_categories[1]
i.save
# item-6
i = Item.new(name: 'Garlic Bread',
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                 price: 199.0,
                 restaurant_id: pizza_hut.id)
i.item_picture.attach(io: File.open('./app/assets/images/pizza_hut/garlic_bread.jpeg'),
                      filename: 'garlic-bread-pizza-hut.jpeg')
i.categories << all_categories[0]
i.categories << all_categories[4]
i.save
# item-7
i = Item.new(name: 'Brownie',
                 description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.
           Lorem Ipsum has been the industry's standard dummy text ever since the 1500s",
                 price: 199.0,
                 restaurant_id: pizza_hut.id)
i.item_picture.attach(io: File.open('./app/assets/images/pizza_hut/brownie.jpeg'), filename: 'brownie-pizza-hut.jpeg')
i.categories << all_categories[2]
i.categories << all_categories[1]
i.save
