# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


photo = File.new("#{Rails.root}/app/assets/images/default.jpeg")

desc1 = 'This is a 16.1 MP Digital Camera with 60x Optical Image Stabilized Zoom and 3 inch LCD. It offers full 1080p HD video recording with auto focus and has realistic Dolby Digital quality sound recording for enhanced audio quality. It comes with 15 filter effects that can be used on your photos and video.'
desc2 = 'This is a 20.1 MP Digital Camera with a 2.7 inch LCD. It can record 720p HD movies. It has face detection technology that detects up to eight individual faces and adjusts focus, exposure and white balance to help deliver crisp, properly lit images of family and friends.'
desc3 = 'This is a 12.1 MP Digital Camera with 30x optical zoom and 1080p full HD video. It has built in Wi-Fi technology for on-the-go convenience when you want to share your photos and videos with friends, family and the whole world.'
desc4 = 'This is an instant film camera. It automatically detects the brightness of the surrounding and adjusts the amount of flash and shutter speed to optimize photo quality. It has kids mode suitable for photographing kids, pets and other fast moving subjects due to a fast shutter speed.'

desc5 = "The BMW 3 Series models combine the joy of driving and practicality for daily use, ranging from the BMW 3 Series Sedan, BMW 3 Series Touring, BMW 3 Series Gran Turismo to the BMW 3 Series Convertible. The BMW ActiveHybrid 3 represents the next generation of hybrid vehicles. Not to forget the true high-performance sports car: the BMW M3 Convertible."
desc6 = "Designed for life and all its ups, downs, lefts, rights, double-backs, get the maps out, stay calm and breathes:  There’s a touch screen navigation system in every Clio Dynamique or Dynamique S."


pana = Brand.create! :name => 'Panasonic', :country => "jp"
sony = Brand.create! :name => 'Sony', :country => "jp"
canon = Brand.create! :name => 'Canon', :country => "jp"
fuji = Brand.create! :name => 'Fujifilm', :country => "jp"

bmw = Brand.create! :name => 'BMW', :country => "de"
renault = Brand.create! :name => 'Renault', :country => "fr"

Product.create! :name => 'Panasonic LUMIX DMC-FZ70', :price => 320.00, :description => desc1, :photo => photo, :brand_id => pana.id, :prod_type => 1
Product.create! :name => 'Sony DSC W830/B', :price => 140.00, :description => desc2, :photo => photo, :brand_id => sony.id, :prod_type => 1
Product.create! :name => 'Canon PowerShot SX510 HS', :price => 230.00, :description => desc3, :photo => photo, :brand_id => canon.id, :prod_type => 1
Product.create! :name => 'Fujifilm Instax Mini 90 Neo Classic Instant Film Camera', :price => 150.00, :description => desc4, :photo => photo, :brand_id => fuji.id, :prod_type => 1

Product.create! :name => 'BMW serie S3', :price => 25000.00, :description => desc5, :photo => photo, :brand_id => bmw.id, :prod_type => 2
Product.create! :name => 'Renault Clio', :price => 15000.00, :description => desc6, :photo => photo, :brand_id => renault.id, :prod_type => 2
