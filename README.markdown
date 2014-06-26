== README

INTRO
=====
This is a small Ruby on Rails application that integrates elastic search. It's a simple products list page with different search features


FEATURES
========
List of features implemented:

- Full text search
- when searching, ajax updates of the list of products and highlights of the search key.
- faceted filtering
- pagination


SCREENSHOTS
===========
Default view:
![Alt text](/public/products_catalog.png?raw=true "screenshot 1")

View after searching for "camera":
![Alt text](/public/products_catalog_2.png?raw=true "screenshot 2")


SETUP
=====
To run the application, you'll need to include a database.yml file in the config directory

I have included a template named database.example.yml

Use it as a guide and change the settings according to your environment and be sure to save the file as database.yml

(If you're using sqlite3, just drop the .example and use as is)

Then start elastic search:
>> elasticsearch --config=/usr/local/opt/elasticsearch/config/elasticsearch.yml

In production, if Bonsai gives you an error about a missing products index, run:
>> heroku run bundle exec rake environment elasticsearch:import:model CLASS='Product' FORCE=true 







