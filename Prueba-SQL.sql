-- Video https://youtu.be/F8vTlWSiKlw


-- BASE DE DATOS

CREATE DATABASE "Desafio-SQL-Cristian-Gallardo-133";

\c Desafio-SQL-Cristian-Gallardo-133


-- 1) Crea el modelo (revisa bien cuál es el tipo de relación antes de crearlo), respeta las claves primarias, foráneas y tipos de datos. 


CREATE TABLE peliculas(id SERIAL PRIMARY KEY, nombre VARCHAR(255), anno INT);

CREATE TABLE tags(id SERIAL PRIMARY KEY, tag VARCHAR(32));

CREATE TABLE peliculas_tags(pelicula_id INT, tag_id INT, FOREIGN KEY (pelicula_id) REFERENCES peliculas(id), FOREIGN KEY (tag_id) REFERENCES tags(id));

-- \d peliculas

-- \d tags

-- \d peliculas_tags



-- 2) Inserta 5 películas y 5 tags, la primera película tiene que tener 3 tags asociados, la segunda película debe tener dos tags asociados. (1 punto)


INSERT INTO peliculas(nombre, anno) VALUES ('The Dark Knight', '2008');
INSERT INTO peliculas(nombre, anno) VALUES ('Pulp Fiction', '1994');
INSERT INTO peliculas(nombre, anno) VALUES ('Godfather', '1972');
INSERT INTO peliculas(nombre, anno) VALUES ('The Shawshank Redemption', '1994');
INSERT INTO peliculas(nombre, anno) VALUES ('The Lord of the Rings: The Return of the King', '2003');

-- SELECT * FROM peliculas;

INSERT INTO tags(tag) VALUES ('Acción');
INSERT INTO tags(tag) VALUES ('Crimen');
INSERT INTO tags(tag) VALUES ('Drama');
INSERT INTO tags(tag) VALUES ('Comedia');
INSERT INTO tags(tag) VALUES ('Ciencia ficción');


-- SELECT * FROM tags;


INSERT INTO peliculas_tags(pelicula_id, tag_id) VALUES (1,1);
INSERT INTO peliculas_tags(pelicula_id, tag_id) VALUES (1,2);
INSERT INTO peliculas_tags(pelicula_id, tag_id) VALUES (1,3);
INSERT INTO peliculas_tags(pelicula_id, tag_id) VALUES (2,2);
INSERT INTO peliculas_tags(pelicula_id, tag_id) VALUES (2,4);


-- SELECT * FROM peliculas_tags;


-- 3) Cuenta la cantidad de tags que tiene cada película. Si una película no tiene tags debe mostrar 0. (1 punto)


SELECT peliculas.nombre, COUNT(peliculas_tags.tag_id) AS "número de tags" FROM peliculas 
LEFT JOIN peliculas_tags ON peliculas.id = peliculas_tags.pelicula_id 
GROUP BY peliculas.nombre;


-- 4) Crea las tablas respetando los nombres, tipos, claves primarias y foráneas y tipos de datos. (1 punto)


CREATE TABLE preguntas(id SERIAL PRIMARY KEY, pregunta VARCHAR(255), respuesta_correcta VARCHAR);

-- \d preguntas

CREATE TABLE usuarios(id SERIAL PRIMARY key, nombre VARCHAR(255), edad INT CHECK (edad>= 18));

-- \d usuarios

CREATE TABLE respuestas(id SERIAL PRIMARY KEY, respuesta VARCHAR(255), usuario_id INT, pregunta_id INT, FOREIGN KEY (usuario_id) REFERENCES usuarios (id) ON DELETE CASCADE, FOREIGN KEY (pregunta_id) REFERENCES preguntas (id) ON DELETE CASCADE);

-- \d respuestas


-- 5) Agrega datos, 5 usuarios y 5 preguntas, la primera pregunta debe estar contestada dos veces correctamente por distintos usuarios, la pregunta 2 debe estar contestada correctamente sólo por un usuario, y las otras 2 respuestas deben estar incorrectas. (1 punto)


INSERT INTO usuarios (nombre, edad) VALUES ('Cristián',22);
INSERT INTO usuarios (nombre, edad) VALUES ('María',24);
INSERT INTO usuarios (nombre, edad) VALUES ('Miguel',26);
INSERT INTO usuarios (nombre, edad) VALUES ('Joaquín',28);
INSERT INTO usuarios (nombre, edad) VALUES ('Francisca',30);

-- SELECT * FROM usuarios;

INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('¿Quién es el autor de la frase "Pienso, luego existo"?', 'Descartes');
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('¿Cuál es el país más grande y el más pequeño del mundo?', 'Rusia y Vaticano' );
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('¿Cuál es el libro más vendido en el mundo después de la Biblia?', 'Don Quijote de la Mancha' );
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('¿En qué periodo de la prehistoria fue descubierto el fuego?', 'Paleolítico');
INSERT INTO preguntas (pregunta, respuesta_correcta) VALUES ('¿Cuál de estos países se extiende entre dos continentes?', 'Rusia' );

-- SELECT * FROM preguntas;

INSERT INTO respuestas (respuesta, usuario_id, pregunta_id) VALUES ('Descartes',1,1);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id) VALUES ('Descartes',2,1);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id) VALUES ('Rusia y Vaticano',4,2);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id) VALUES ('Paleolítico',3,3);
INSERT INTO respuestas (respuesta, usuario_id, pregunta_id) VALUES ('Don Quijote de la Mancha',5,5);


-- SELECT * FROM respuestas; 


-- 6) Cuenta la cantidad de respuestas correctas totales por usuario (independiente de la pregunta). (1 punto)

SELECT usuarios.id, usuarios.nombre, COUNT(preguntas.respuesta_correcta) AS "respuestas correctas" FROM usuarios
LEFT JOIN respuestas ON usuarios.id = respuestas.usuario_id
LEFT JOIN preguntas ON respuestas.pregunta_id = preguntas.id
AND respuestas.respuesta = preguntas.respuesta_correcta
GROUP BY usuarios.id, usuarios.nombre
ORDER BY usuarios.id;

-- 7) Por cada pregunta, en la tabla preguntas, cuenta cuántos usuarios tuvieron la respuesta correcta. (1 punto)

SELECT preguntas.pregunta, COUNT(respuestas.respuesta) AS "número de usuarios" FROM preguntas
LEFT JOIN respuestas ON preguntas.id = respuestas.pregunta_id
AND preguntas.respuesta_correcta = respuestas.respuesta
GROUP BY preguntas.id, preguntas.pregunta
ORDER BY preguntas.id;

-- 8)Implementa borrado en cascada de las respuestas al borrar un usuario y borrar el primer usuario para probar la implementación. (1 punto)

DELETE FROM usuarios WHERE id = 1;

-- SELECT * FROM usuarios;
-- SELECT * FROM preguntas;

-- 9) Crea una restricción que impida insertar usuarios menores de 18 años en la base de datos. (1 punto)

INSERT INTO usuarios (nombre, edad) VALUES ('Claudia',15);

--10) Altera la tabla existente de usuarios agregando el campo email con la restricción de único. (1 punto)

ALTER TABLE usuarios
ADD COLUMN email VARCHAR UNIQUE; 

-- \d usuarios

-- SELECT * FROM usuarios; 