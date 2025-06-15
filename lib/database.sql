select * from locker;

select * from client;

select * from controller;

select * from door;

select * from user;

select * from movement;

select *
from door
    inner join door_size on door.door_size_id = door_size.door_size_id;

SELECT door.*
from door
    LEFT JOIN movement on door.door_id = movement.door_id
WHERE (
        movement.delivered = 1
        or movement.delivered is NULL
    );

select * from movement;

select * from door;

select * from user;

select * from door_size;

select * from user;

INSERT INTO
    `movement` (`door_id`, `code`)
VALUES (2, '4464845233'),
    (5, '4464845233'),
    (6, '4464845233'),
    (7, '4464845233'),
    (8, '4464845233'),
    (9, '4464845233');

UPDATE movement set delivered = 1 WHERE movement.movement_id = 1

SELECT door.number, door.door_id, door_size.name
FROM
    door
    INNER JOIN door_size on door.door_size_id = door_size.door_size_id
    LEFT JOIN movement on movement.door_id = door.door_id
WHERE (
        movement.delivered is NULL
        or movement.delivered > 0
    )
    and door_size.door_size_id = 3;


 SELECT door.number, door_size.name, movement.movement_id, movement.create_at, movement.code FROM movement INNER JOIN door on door.door_id=movement.door_id INNER JOIN door_size on door_size.door_size_id=door.door_size_id WHERE movement.code='113762' and movement.delivered=0
 
 SELECT request_comand.comand as request_comand, response_comand.name as name_request, response_comand.comand as response_comand, response_comand.name as name_response FROM request_comand INNER JOIN door on door.door_id=request_comand.door_id INNER JOIN response_comand on response_comand.request_comand_id=request_comand.request_comand_id where door.door_id=1 and request_comand.name='lectura';
 