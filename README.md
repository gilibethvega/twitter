# README
Usuario para pruebas en local: test@test.com // password: vamoscon

Link a heroku https://twitter-gili.herokuapp.com/

Hito 2

Para validar las historias del hito 2 se puede visitar las siguientes páginas:

1) Para los followers, se creo el la vista https://twitter-gili.herokuapp.com/home/users disponible en el navbar, aca se pueden seguir y dejar de seguir usuarios.

2) Para el administrador se creo la ruta https://twitter-gili.herokuapp.com/admin/users con la clave y usuario temporal: email: 'admin@example.com', password: 'password' para su validación.


Hito 3

Para consultar en postman:

Historia 1:

Headers: Key => Content-Type // Value => application/json
Method: GET
URL = http://localhost:3000/api/news

Historia 2:

Headers: Key => Content-Type // Value => application/json
Method: GET
URL = http://localhost:3000/api/2021-03-01/2021-03-15 (ejemplo)

Historia 3:
Autorization // Basic auth
username = desafio // password = latam

Headers: Key => Content-Type // Value => application/json
Method: POST
Body: 
{
    "content": "Tu nuevo tweeet",
    "user_id": 2
}
url = http://localhost:3000/tweets/create_tweet