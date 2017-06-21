# forecaster

Forecaster is an app I wrote as a job interview take home project.

## Dependencies/Versions:

* Ruby version 2.3.1

* Rails version 5.0.4

* Open Weather API Key (http://home.openweathermap.org/users/sign_up)

* [Open Weather API Reference](http://openweathermap.org/api)

* PostgreSQL 9.5.3 (although it isn't used)

* ENV Handling gem (dotenv-rails)

* net/http (https://ruby-doc.org/stdlib-2.4.1/libdoc/net/http/rdoc/Net/HTTP.html)


#### Setup Locally

Clone Repo
```
git clone https://github.com/colinxchristmas/forecaster.git
```

Change dir into `forecaster`

```
cd forecaster
```

Install Gems

```
bundle install
```

Setup Database (no database models used)
```
rake db:create
rake db:migrate
```

Setup a `.env` file
After you get your API key from Open Weather (http://openweathermap.org/appid)
Add key to `.env`

```
OPEN_WEATHER_KEY=''
```

Start the server and navigate to (http://localhost:3000/)

```
rails s
```

### Testing
As this was a rather quick turn around time I haven't implemented any tests.

### How it works.

Functionality is in place for just US zipcode weather with a current forecast. I have part of the implementation for building a query in the `/services` call but ran a bit short on time to implement it.

Cookies are stored in the user session with an expiration. Subsequent calls to the same zip code are pulled from the session cookie rather than a second call to the API.

Cookes are prepended with `_forecaster_` and then the individual zipcode `12345` to separate them into individual expiring cookies, rather than written to an entire expiring session.

I decided to avoid saving anything to the database to keep it lean. I'm sure there are quite a few better ways to cache the data like `redis`, but due to time I wasn't able to do that.

Formatting is very basic. At some point I may revisit this to clean up the form and add some bootstrap styling to it.
