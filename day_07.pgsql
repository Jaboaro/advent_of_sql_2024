WITH 
    experience_min AS (
        SELECT DISTINCT ON (primary_skill)
            elf_id,
            primary_skill,
            years_experience
        FROM workshop_elves
        ORDER BY primary_skill, years_experience, elf_id
    ),

    experience_max AS (
        SELECT DISTINCT ON (primary_skill)
            elf_id,
            primary_skill,
            years_experience
        FROM workshop_elves
        ORDER BY primary_skill, years_experience DESC, elf_id
    )

SELECT 
    maxex.elf_id AS max_years_experience_elf_id, 
    minex.elf_id AS min_years_experience_elf_id, 
    maxex.primary_skill AS shared_skill
    FROM experience_min minex
    JOIN experience_max maxex
        ON maxex.primary_skill = minex.primary_skill;
