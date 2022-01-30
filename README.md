# README

In this project, I was only able to focus on the background. I gave importance to code readability and testability.

When I started focusing on the front side, unfortunately I got some weird webpacker errors and I didn't have time to fix them.

After running the project, just calling the url is enough for the program to run.

Since there is no cache at first, a 404 - warning message will appear.

like : 
```
http://localhost:3000/api/forecasts?address=1775 Milmont Dr, Milpitas, 95035

```
<img width="815" alt="Screen Shot 2022-01-30 at 3 12 45 PM" src="https://user-images.githubusercontent.com/4965162/151721931-7e94c688-745b-45a2-bfae-4774db0a4c35.png">

If you try again call this url after 3-4 seconds, you can see the results. As I said I was only able to return a json.

like : 

<img width="1914" alt="Screen Shot 2022-01-30 at 3 14 10 PM" src="https://user-images.githubusercontent.com/4965162/151721974-d408b8eb-e779-4dc2-9da8-14c6ac3a22b1.png">

The results come in this JSON format.

```
{
   "current":{
      "temp_f":57.2,
      "last_updated":"2022-01-30 14:00"
   },
   "max_min":{
      "maxtemp_f":68.7,
      "mintemp_f":43.2
   },
   "hours":[
      {
         "time_epoch":1643529600,
         "time":"2022-01-30 00:00",
         "temp_f":46.6
      },
      {
         "time_epoch":1643533200,
         "time":"2022-01-30 01:00",
         "temp_f":46.0
      },
      {
         "time_epoch":1643536800,
         "time":"2022-01-30 02:00",
         "temp_f":46.2
      },
      {
         "time_epoch":1643540400,
         "time":"2022-01-30 03:00",
         "temp_f":45.7
      },
      {
         "time_epoch":1643544000,
         "time":"2022-01-30 04:00",
         "temp_f":45.9
      },
      {
         "time_epoch":1643547600,
         "time":"2022-01-30 05:00",
         "temp_f":45.9
      },
      {
         "time_epoch":1643551200,
         "time":"2022-01-30 06:00",
         "temp_f":44.6
      },
      {
         "time_epoch":1643554800,
         "time":"2022-01-30 07:00",
         "temp_f":43.7
      },
      {
         "time_epoch":1643558400,
         "time":"2022-01-30 08:00",
         "temp_f":43.2
      },
      {
         "time_epoch":1643562000,
         "time":"2022-01-30 09:00",
         "temp_f":45.7
      },
      {
         "time_epoch":1643565600,
         "time":"2022-01-30 10:00",
         "temp_f":53.1
      },
      {
         "time_epoch":1643569200,
         "time":"2022-01-30 11:00",
         "temp_f":61.0
      },
      {
         "time_epoch":1643572800,
         "time":"2022-01-30 12:00",
         "temp_f":64.4
      },
      {
         "time_epoch":1643576400,
         "time":"2022-01-30 13:00",
         "temp_f":64.8
      },
      {
         "time_epoch":1643580000,
         "time":"2022-01-30 14:00",
         "temp_f":66.7
      },
      {
         "time_epoch":1643583600,
         "time":"2022-01-30 15:00",
         "temp_f":68.7
      },
      {
         "time_epoch":1643587200,
         "time":"2022-01-30 16:00",
         "temp_f":68.5
      },
      {
         "time_epoch":1643590800,
         "time":"2022-01-30 17:00",
         "temp_f":66.7
      },
      {
         "time_epoch":1643594400,
         "time":"2022-01-30 18:00",
         "temp_f":61.9
      },
      {
         "time_epoch":1643598000,
         "time":"2022-01-30 19:00",
         "temp_f":56.8
      },
      {
         "time_epoch":1643601600,
         "time":"2022-01-30 20:00",
         "temp_f":50.9
      },
      {
         "time_epoch":1643605200,
         "time":"2022-01-30 21:00",
         "temp_f":50.5
      },
      {
         "time_epoch":1643608800,
         "time":"2022-01-30 22:00",
         "temp_f":50.0
      },
      {
         "time_epoch":1643612400,
         "time":"2022-01-30 23:00",
         "temp_f":49.8
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
 - spec 

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# foreacast
