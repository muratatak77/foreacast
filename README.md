# README


In this project, I was only able to focus on the background. I gave importance to code readability and testability.

After running the project, you can call the url.

Since there is no cache at first, a 404 - warning message will appear.


![Screen Shot 2022-01-31 at 7 35 01 PM](https://user-images.githubusercontent.com/4965162/151909263-67212f64-051f-4c33-b7b7-7c1be90f5a3d.png)



If you try again call this url after 3-4 seconds, you can see the results.

![Screen Shot 2022-01-31 at 8 00 19 PM](https://user-images.githubusercontent.com/4965162/151910977-2f8be721-2fe9-486a-abb1-61d1d59dec52.png)




The api results come in this JSON format.

```
{
   "location":{
      "name":"Milpitas",
      "region":"California"
   },
   "current":{
      "temp_f":51.8,
      "last_updated":"2022-01-31 17:00"
   },
   "max_min":{
      "maxtemp_f":60.8,
      "mintemp_f":46.4
   },
   "hours":[
      {
         "time_epoch":1643616000,
         "time":"2022-01-31 00:00",
         "temp_f":49.5
      },
      {
         "time_epoch":1643619600,
         "time":"2022-01-31 01:00",
         "temp_f":48.6
      },
      {
         "time_epoch":1643623200,
         "time":"2022-01-31 02:00",
         "temp_f":48.2
      },
      {
         "time_epoch":1643626800,
         "time":"2022-01-31 03:00",
         "temp_f":47.7
      },
      {
         "time_epoch":1643630400,
         "time":"2022-01-31 04:00",
         "temp_f":47.1
      },
      {
         "time_epoch":1643634000,
         "time":"2022-01-31 05:00",
         "temp_f":47.1
      },
      {
         "time_epoch":1643637600,
         "time":"2022-01-31 06:00",
         "temp_f":46.9
      },
      {
         "time_epoch":1643641200,
         "time":"2022-01-31 07:00",
         "temp_f":46.6
      },
      {
         "time_epoch":1643644800,
         "time":"2022-01-31 08:00",
         "temp_f":46.4
      },
      {
         "time_epoch":1643648400,
         "time":"2022-01-31 09:00",
         "temp_f":47.8
      },
      {
         "time_epoch":1643652000,
         "time":"2022-01-31 10:00",
         "temp_f":51.6
      },
      {
         "time_epoch":1643655600,
         "time":"2022-01-31 11:00",
         "temp_f":55.2
      },
      {
         "time_epoch":1643659200,
         "time":"2022-01-31 12:00",
         "temp_f":57.6
      },
      {
         "time_epoch":1643662800,
         "time":"2022-01-31 13:00",
         "temp_f":59.2
      },
      {
         "time_epoch":1643666400,
         "time":"2022-01-31 14:00",
         "temp_f":60.6
      },
      {
         "time_epoch":1643670000,
         "time":"2022-01-31 15:00",
         "temp_f":60.8
      },
      {
         "time_epoch":1643673600,
         "time":"2022-01-31 16:00",
         "temp_f":60.6
      },
      {
         "time_epoch":1643677200,
         "time":"2022-01-31 17:00",
         "temp_f":59.5
      },
      {
         "time_epoch":1643680800,
         "time":"2022-01-31 18:00",
         "temp_f":56.5
      },
      {
         "time_epoch":1643684400,
         "time":"2022-01-31 19:00",
         "temp_f":52.2
      },
      {
         "time_epoch":1643688000,
         "time":"2022-01-31 20:00",
         "temp_f":49.6
      },
      {
         "time_epoch":1643691600,
         "time":"2022-01-31 21:00",
         "temp_f":48.4
      },
      {
         "time_epoch":1643695200,
         "time":"2022-01-31 22:00",
         "temp_f":47.7
      },
      {
         "time_epoch":1643698800,
         "time":"2022-01-31 23:00",
         "temp_f":47.1
      }
   ]
}
```

If we talk a little about the structure, when we realize that there is no cache in the first place, we update the cache by running a 'Job', connecting to the relevant API and pulling the data. After the cache is updated, the data is now directly cached.

Job class :  https://github.com/muratatak77/foreacast/blob/main/app/jobs/service_weatherapi_job.rb

It is cached for 30 minutes. You can see there is a default expire_in params in the redis store. 

```
    config.cache_store = :redis_store, redish_hash, { expires_in: 30.minutes}
```

The cache is kept in the redis store, you must have a Redis installed in your locale.


Our module that fetchs and updates the data:

https://github.com/muratatak77/foreacast/tree/main/lib/service/weatherapi



Things you may want to cover:

* Ruby version
  - ruby 2.6.4p104 (2019-08-28 revision 67798) [x86_64-darwin18]

* System dependencies

* Configuration

* Database creation
  - None

* Database initialization
  - None

* How to run the test suite
```  
spec 
```
* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# foreacast
