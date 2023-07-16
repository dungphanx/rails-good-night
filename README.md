# Good Night app API

## Usage

- Install dependencies with `bundle install`

Run:

- `rails db:create db:migrate` (to create the database tables)
- `rails db:seed` (to install basic seed data)

To run the tests:

- `bundle exec rspec`

To start up a server:

- `rail s`

## Routes

- To test the routes, it is recommended to use a service like **Postman**.

### GET /users returns a list of users and attributes

```
[
  {
    "id": 1,
    "name": "John",
    "sleep_records": [
      {
        "id": 1,
        "bed_time": "2023-07-01T15:00:00.000Z",
        "wake_up_time": "2023-07-01T23:30:00.000Z"
      },
      {
        "id": 4,
        "bed_time": "2023-07-02T15:30:00.000Z",
        "wake_up_time": "2023-07-03T00:30:00.000Z"
      }
    ],
    "followers": []
  },
  {
    "id": 2,
    "name": "Jane",
    "sleep_records": [
      {
        "id": 2,
        "bed_time": "2023-07-01T16:30:00.000Z",
        "wake_up_time": "2023-07-02T00:00:00.000Z"
      },
      {
        "id": 5,
        "bed_time": "2023-07-02T16:00:00.000Z",
        "wake_up_time": "2023-07-02T23:00:00.000Z"
      }
    ],
    "followers": [
      {
        "id": 1,
        "name": "John"
      }
    ]
  }
]
```

1. Clock In operation, and return all clocked-in times, ordered by created time.

> POST api/v1/sleep_records
>
> - params: user_id, bed_time, wake_up_time
>
> POST api/v1/sleep_records/track
>
> - params: user_id

2. Users can follow and unfollow other users.

> POST api/v1/follows
>
> - params: user_id, followed_user_id
>
> DELETE api/v1/follows/unfollow
>
> - params: user_id, followed_user_id

3. See the sleep records of a user’s All following users’ sleep records. from the previous week, which are sorted based on the duration of All friends sleep length.
   > GET api/v1/friend_sleep_records/:user_id
