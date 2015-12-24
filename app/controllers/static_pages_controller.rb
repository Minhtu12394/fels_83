class StaticPagesController < ApplicationController
  layout "api_document", only: :api_document
  def home
    @activities = Activity.feed_activities_by(current_user.id).order(created_at: :desc)
      .paginate page: params[:page] if logged_in?
  end

  def help
  end

  def about
  end

  def contact
  end

  def api_document
    current_domain = request.base_url
    @str = <<-API_DOCUMENT
<div class="text-center">
  <h1><b>API Reference</b></h1>
</div>

## **Sign up**

**URL**: [http://localhost:3000/users.json](http://localhost:3000/users.json)

**Method**: **POST**

**Param request**:
`- user[name]`, type: string, presence: true, length: {maximum: 50}
`- user[email]`, type: string, presence: true, length: {maximum: 255}
`- user[password]`, type: string, length: {minimum: 6}, presence: true
`- user[password_confirmation]`, type: string

**Request example**
`POST: {"user": {"name": "Example User", "email": "email@example.com", "password": "123456", "password_confirmation": "123456"}}`

**Response**:
`{"message": "Sign up success"}`

## **Sign in**

**URL**: [http://localhost:3000/login.json](http://localhost:3000/login.json)

**Method**: **POST**

**Param request**:
`- session[email]`, type: string, presence: true
`- session[password]`, type: string, presence: true
`- session[remember_me]`, type: integer(1 is remember, 0 is forget)

**Request example**
`POST: {"session": {"email": "email@example.com", "password": "123456", "remember_me": "1"}`


**Response**:
`{"user": {"id": 1, "name": "Nguyen Tien Manh", "email":"example@railstutorial.org", "avatar": "http://localhost:3000/uploads/user/avatar/1/Screenshot_from_2015-12-14_14_47_00.png", "admin": true, "auth_token": "E6nAVPWqAsMH0hvTquTipg", "created_at": "2015-12-11T03:30:31.000Z", "updated_at": "2015-12-11T04:09:51.000Z", "activities": [{"id":1, "content": "Logout", "created_at": "2015-12-11T03:37:06.000Z"}, {"id": 2, "content": "Login", "created_at": "2015-12-11T03:37:08.000Z"}]}}`

## **Sign out**

**URL**: [http://localhost:3000/logout.json](http://localhost:3000/logout.json)

**Method**: **DELETE**

**Param request**:

**Response**:
`{"message": "Logout success"}`

## **Get categories**

**URL**: [http://localhost:3000/categories.json?auth_token=E6nAVPWqAsMH0hvTquTipg](http://localhost:3000/categories.json?auth_token=E6nAVPWqAsMH0hvTquTipg)

**Method**: **GET**

**Param request**:
`- page`, type: integer, numericality: {greater&#95;than&#95;or&#95;equal&#95;to: 0}
`- auth_token`, type: string, presence: true

**Request example**
`GET: http://localhost:3000/categories.json?page=3`

**Response**:
`{"categories": [{"id": 15, "name": "International Mobility Liason"}, {"id": 14, "name": "Regional Branding Representative"}]}`

## **Create lesson**
**URL**: [http://localhost:3000/categories/1/lessons.json](http://localhost:3000/categories/1/lessons.json)

**Method**: **POST**

**Param request**:
`- auth_token`, type: string, presence: true

**Response**:
`{"lesson": {"id": 3, "name": "#3", "words": [{"id": 20, "result_id": 123, "content": "v922p", "answers": [{"id": 77, "content": "dck8v", is_correct: false}, {"id": 78, "content": "mm9hf", is_correct: true}, {"id": 79, "content": "mcmwn", is_correct: false}, {"id": 80, "content": "lopus", is_correct: false}]}]}}`

## **Update lesson**

**URL**: [http://localhost:3000/lessons/3.json](http://localhost:3000/lessons/3.json)

**Method**: **PATCH**

**Param request**:
`- lesson[learned]`, type: boolean, presence: true
`- lesson[results_attributes][0][id]`, type: integer
`- lesson[results_attributes][0][answer_id]`, type: integer
`- lesson[results_attributes][1][id]`, type: integer
`- lesson[results_attributes][1][answer_id]`, type: integer
`- auth_token`, type: string, presence: true

**Request example**
`PATCH: {"lesson": {"learned": "true", "results_attributes": {"0": {"answer_id": "19", "id": "1"}, "1": {"answer_id": "118", "id": "2"}, "2": {"answer_id": "54", "id": "3"}, "3": {"answer_id": "48", "id": "4"}, "4": {"answer_id": "109", "id": "5"}, "5": {"answer_id": "8", "id": "6"}, "6": {"id": "7"}, "7": {"id": "8"}, "8": {"id": "9"}, "9": {"id": "10"}, "10": {"id": "11"}, "11": {"id": "12"}, "12": {"id": "13"}, "13": {"id": "14"}, "14": {"id": "15"}, "15": {"id": "16"}, "16": {"id": "17"}, "17": {"id": "18"}, "18": {"id": "19"}, "19": {"id": "20"}}}`

**Response**:
`{"lesson": {"id": 3, "name": "#3", "words": [{"id": 20, "content": "v922p", "answers": [{"id": 77, "content": "dck8v"}, {"id": 78, "content": "mm9hf"}, {"id": 79, "content": "mcmwn"}, {"id": 80, "content": "lopus"}]}]}}`

## **Word list**

**URL**: [http://localhost:3000/words.json](http://localhost:3000/words.json)

**Method**: **GET**

**Param request**:
`- category_id`, type: integer
`- option`, type: string("all&#95;word", "learned" or "no&#95;learn")
`- page`, type: integer, numericality: {greater&#95;than: 0}
`- auth_token`, type: string, presence: true

**Request example**
`GET: http://localhost:3000/words.json?category_id=5&option=all_word`

**Response**:
`{"words": [{"id": 1, "content": "fe9kk", "answers": [{"id": 1, "content": "p2jh8", is_correct: true}, {"id": 2, "content": "dg0st", is_correct: false}, {"id": 3, "content": "2vq33", is_correct: false}, {"id": 4, "content": "l8t2b", is_correct: false}]}]}`

## **Show user**

**URL**: [http://localhost:3000/users/1.json](http://localhost:3000/users/1.json)

**Method**: **GET**

**Param request**:
`- auth_token`, type: string, presence: true

**Response**:
`{"user": {"id": 1, "name": "Nguyen Tien Manh", "email": "example@railstutorial.org", "avatar": "http://localhost:3000/uploads/user/avatar/1/Screenshot_from_2015-12-14_14_47_00.png", "admin": true, "created_at": "2015-12-11T03:30:31.000Z", "updated_at": "2015-12-11T04:09:51.000Z", "activities": [{"id": 1, "content": "Logout", "created_at": "2015-12-11T03:37:06.000Z"}, {"id": 2, "content": "Login", "created_at": "2015-12-11T03:37:08.000Z"}]}}`

## **Update profile**

**URL**: [http://localhost:3000/users/1.json](http://localhost:3000/users/1.json)

**Method**: **PATCH**

**Param request**:
`- user[name]`, type: string, presence: true, length: {maximum: 50}
`- user[password]`, type: string, length: {minimum: 6}, presence: true, allow&#95;nil: true
`- user[password_confirmation]`, type: string
`- user[avatar]`, type: file
`- auth_token`, type: string, presence: true

**Request example**
`PATCH: {"user": {"name": "Example User", "email": "email@example.com", "password": "123456", "password_confirmation": "123456"}}`

**Response**:
`{"user": {"id": 1, "name": "Nguyen Tien Manh", "email": "example@railstutorial.org", "admin": true, "created_at": "2015-12-11T03:30:31.000Z", "updated_at": "2015-12-11T04:09:51.000Z", "activities": [{"id": 1, "content": "Logout", "created_at": "2015-12-11T03:37:06.000Z"}, {"id": 2, "content": "Login", "created_at": "2015-12-11T03:37:08.000Z"}]}}`

## **Make follow**

**URL**: [http://localhost:3000/relationships.json](http://localhost:3000/relationships.json)

**Method**: **POST**

**Param request**:
`- followed_id`, type: integer, presence: true
`- auth_token`, type: string, presence: true

**Request example**
`POST: {"followed_id": "66"}`

**Response**:
`{"message": "Follow success"}`

## **Make unfollow**

**URL**: [http://localhost:3000/relationships/1.json](http://localhost:3000/relationships/1.json)

**Method**: **DELETE**

**Param request**:
`- auth_token`, type: string, presence: true

**Response**:
`{"message": "Unfollow success"}`
    API_DOCUMENT
    @str.gsub! "http://localhost:3000", current_domain
  end
end
