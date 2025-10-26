CREATE TABLESPACE tspace_fast LOCATION 'C:/Users/user/PostgreSQL/tspace_fast';
CREATE TABLESPACE tspace_slow LOCATION 'C:/Users/user/PostgreSQL/tspace_slow';

CREATE SCHEMA core;
CREATE SCHEMA ref;

ALTER SCHEMA core SET TABLESPACE tspace_fast;
ALTER SCHEMA ref SET TABLESPACE tspace_slow;
