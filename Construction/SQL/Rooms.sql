Select HomeTypeID,Description + ' - ' + Code as Desp From HomeType
WHERE isDelete = 0

Select RoomTypeID,Description + ' - ' + Code as Desp From RoomType
WHERE isDelete = 0

Select * From Rooms