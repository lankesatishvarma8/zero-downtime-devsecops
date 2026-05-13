# Expand-Contract Database Migration Strategy

## Expand Phase
New schema changes are introduced without breaking the old application version.

Example:

ALTER TABLE users ADD COLUMN phone_new VARCHAR(20);

## Dual Support Phase
Application supports both old and new columns simultaneously.

## Data Migration Phase
Existing data is copied from old schema to new schema gradually.

## Contract Phase
After validation, old schema elements are removed safely.

Example:

ALTER TABLE users DROP COLUMN phone;
