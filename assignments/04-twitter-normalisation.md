# Assignment 4: Twitter normalisation

Given a SQN table over some Twitter data, construct a normalised relation to the 3rd NF based on the schema below.

* **Deadline**: 6th of March 12:00
* **Review**: 7th of March 23:59
* Hand-in the SQL commands necessary to construct the tables you believe to be in 3rd NF
* If you are interested, data is available here: http://followthehashtag.com/datasets/free-twitter-dataset-usa-200000-free-usa-tweets/

      create table tweet (
        id        bigint primary key,
        date      date,
        hour      time,
        uname     text,
        nickname  text,
        bio       text,               -- User biography
        message   text,
        favs      bigint,             -- Number of user that favourited  this tweet
        rts       bigint,             -- Number of times this tweet has  been retweeted
        latitude  double precision,
        longitude double precision,
        country   text,               -- The country where this tweet  was tweeted from
        place     text,               -- The name of the location thi  tweet was tweeted from (if any)
        picture   text,               -- A picture in this tweet (if any)
        followers bigint,             -- Number of users followers
        following bigint,             -- Number of users following
        listed    bigint,             -- ID of the list, this tweet  belongs to (if any)
                                      -- In Twitter a tweet can be an a list (conversation), started by a user
        lang      text,               -- Tweet language (not user)
        url       text                -- Tweet URL
      );
