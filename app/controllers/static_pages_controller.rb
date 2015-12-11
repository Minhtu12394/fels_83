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
`- user[name]`
`- user[email]`
`- user[password]`
`- user[password_confirmation]`

**Response**:
`{"message": "Sign up success"}`

## **Sign in**

**URL**: [http://localhost:3000/login.json](http://localhost:3000/login.json)

**Method**: **POST**

**Param request**:
`- session[email]`
`- session[password]`
`- session[remember_me]`

**Response**:
`{"user": {"id": 1, "name": "Nguyen Tien Manh", "email":"example@railstutorial.org", "admin": true, "created_at": "2015-12-11T03:30:31.000Z", "updated_at": "2015-12-11T04:09:51.000Z", "activities": [{"id":1, "content": "Logout", "created_at": "2015-12-11T03:37:06.000Z"}, {"id": 2, "content": "Login", "created_at": "2015-12-11T03:37:08.000Z"}]}}`

## **Sign out**

**URL**: [http://localhost:3000/logout.json](http://localhost:3000/logout.json)

**Method**: **DELETE**

**Param request**:

**Response**:
`{"message": "Logout success"}`

## **Get categories**

**URL**: [http://localhost:3000/categories.json](http://localhost:3000/categories.json)

**Method**: **GET**

**Param request**:
`- page`
`- per_page`

**Response**:
`{"categories": [{"id": 15, "name": "International Mobility Liason"}, {"id": 14, "name": "Regional Branding Representative"}]}`

## **Create lesson**
**URL**: [http://localhost:3000/categories/1/lessons.json](http://localhost:3000/categories/1/lessons.json)

**Method**: **POST**

**Param request**:

**Response**:
`{"lesson": {"id": 3, "name": "#3", "words": [{"id": 20, "content": "v922p", "answers": [{"id": 77, "content": "dck8v"}, {"id": 78, "content": "mm9hf"}, {"id": 79, "content": "mcmwn"}, {"id": 80, "content": "lopus"}]}]}}`

## **Update lesson**

**URL**: [http://localhost:3000/lessons/3.json](http://localhost:3000/lessons/3.json)

**Method**: **PATCH**

**Param request**:
`- lesson[learned]`
`- lesson[results_attributes][0][id]`
`- lesson[results_attributes][0][answer_id]`
`- lesson[results_attributes][1][id]`
`- lesson[results_attributes][1][answer_id]`

**Response**:
`{"lesson": {"id": 3, "name": "#3", "words": [{"id": 20, "content": "v922p", "answers": [{"id": 77, "content": "dck8v"}, {"id": 78, "content": "mm9hf"}, {"id": 79, "content": "mcmwn"}, {"id": 80, "content": "lopus"}]}]}}`

## **Word list**

**URL**: [http://localhost:3000/words.json](http://localhost:3000/words.json)

**Method**: **GET**

**Param request**:
`- category_id`
`- option`
`- page`

**Response**:
`{"words": [{"id": 1, "content": "fe9kk", "answers": [{"id": 1, "content": "p2jh8"}, {"id": 2, "content": "dg0st"}, {"id": 3, "content": "2vq33"}, {"id": 4, "content": "l8t2b"}]}]}`

## **Show user**

**URL**: [http://localhost:3000/users/1.json](http://localhost:3000/users/1.json)

**Method**: **GET**

**Param request**:

**Response**:
`{"user": {"id": 1, "name": "Nguyen Tien Manh", "email": "example@railstutorial.org", "admin": true, "created_at": "2015-12-11T03:30:31.000Z", "updated_at": "2015-12-11T04:09:51.000Z", "activities": [{"id": 1, "content": "Logout", "created_at": "2015-12-11T03:37:06.000Z"}, {"id": 2, "content": "Login", "created_at": "2015-12-11T03:37:08.000Z"}]}}`

## **Update profile**

**URL**: [http://localhost:3000/users/1.json](http://localhost:3000/users/1.json)

**Method**: **PATCH**

**Param request**:
`- user[name]`
`- user[password]`
`- user[password_confirmation]`

**Response**:
`{"user": {"id": 1, "name": "Nguyen Tien Manh", "email": "example@railstutorial.org", "admin": true, "created_at": "2015-12-11T03:30:31.000Z", "updated_at": "2015-12-11T04:09:51.000Z", "activities": [{"id": 1, "content": "Logout", "created_at": "2015-12-11T03:37:06.000Z"}, {"id": 2, "content": "Login", "created_at": "2015-12-11T03:37:08.000Z"}]}}`

## **Make follow**

**URL**: [http://localhost:3000/relationships.json](http://localhost:3000/relationships.json)

**Method**: **POST**

**Param request**:
`- followed_id`

**Response**:
`{"message": "Follow success"}`

## **Make unfollow**

**URL**: [http://localhost:3000/relationships/1.json](http://localhost:3000/relationships/1.json)

**Method**: **DELETE**

**Param request**:

**Response**:
`{"message": "Unfollow success"}`
    API_DOCUMENT
    @str.gsub! "http://localhost:3000", current_domain
  end
end
