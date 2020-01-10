sp_who2

SELECT session_id,(user_objects_alloc_page_count*8/1024) AS SpaceUsedByTheSessionMB,* 
FROM	sys.dm_db_session_space_usage DDSSU
WHERE	database_id=DB_ID('tempdb')
AND		user_objects_alloc_page_count > 0

SELECT SUM(unallocated_extent_page_count) AS [free pages], 
(SUM(unallocated_extent_page_count)*1.0/128) AS [free space in MB]
FROM sys.dm_db_file_space_usage;

SELECT
SUM (user_object_reserved_page_count)*8 as user_obj_kb,
SUM (internal_object_reserved_page_count)*8 as internal_obj_kb,
SUM (version_store_reserved_page_count)*8  as version_store_kb,
SUM (unallocated_extent_page_count)*8 as freespace_kb,
SUM (mixed_extent_page_count)*8 as mixedextent_kb
FROM sys.dm_db_file_space_usage