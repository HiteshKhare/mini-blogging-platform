# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



API steps:-
	User SIgnup URL - POST - http://localhost:3000/api/v1/users
		data - {
				  "user": {
				    "email": "user@example.com",
				    "password": "password123",
				    "password_confirmation": "password123",
				    "name": "User"
				  }
				}


	User SIgn_in URL - POST - http://localhost:3000/api/v1/users/sign_in
		data - {
				  "user": {
				    "email": "user@example.com",
				    "password": "password123"
				  }
				}

	Create New Post URL - POST - http://localhost:3000/api/v1/posts
		data - {
				  "post": {
				    "user_id": 1,
				    "title": "Your Post Title",
				    "body": "Your Post Body"
				  }
				}

	Get a Single Post URL - GET - http://localhost:3000/api/v1/posts/1


	Get All Post/Index page URL - GET - http://localhost:3000/api/v1/posts

	Update a Post URL - PUT - http://localhost:3000/api/v1/posts/1
		data - {
				  "post": {
				    "user_id": 1,
				    "title": "Updated Your Post Title",
				    "body": "Updated Your Post Body"
				  }
				}
	Delete a Post URL - DELETE - http://localhost:3000/api/v1/posts/1

	Create a Comment - POST - URL - http://localhost:3000/api/v1/posts/1/comments
		data - {
				  "comment": {
				    "body": "This is a comment.",
				    "user_id": 1
				  }
				}


	Get All Comments for a Post URL - GET - http://localhost:3000/api/v1/posts/2/comments

	Get a Single Comment URL - GET - http://localhost:3000/api/v1/posts/2/comments/1

	Update a Comment URL - PUT - http://localhost:3000/api/v1/posts/2/comments/1
		data - {
				  "comment": {
				    "body": "This is an updated comment."
				  }
				}


	Delete a Comment URL - DELETE - http://localhost:3000/api/v1/posts/1/comments/1

	



