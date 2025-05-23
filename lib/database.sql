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
    and door_size.door_size_id = 3