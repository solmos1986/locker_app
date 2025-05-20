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