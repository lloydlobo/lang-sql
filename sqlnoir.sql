/* See https://sqlnoir.com */
/*
===============================================================================
Case #001: The Vanishing Briefcase

Set in the gritty 1980s, a valuable briefcase has disappeared from the Blue
Note Lounge. A witness reported that a man in a trench coat was seen fleeing
the scene. Investigate the crime scene, review the list of suspects, and
examine interview transcripts to reveal the culprit.

Objectives:
1. Retrieve the correct crime scene details to gather the key clue.
2. Identify the suspect whose profile matches the witness description.
3. Verify the suspect using their interview transcript.
*/
with
    crime_scene_cte as (
        select *
        from crime_scene
        where
            type = "theft"
            and description like "%briefcase%"
            and location like "%Blue Note%"
    ),  /* => Scar on *left cheek* revealed in the filtered description */
    suspect_cte as (
        select * from suspects where attire = "trench coat" and scar like "left cheek%"
    ),
    interview_cte as (select * from interviews where transcript is not null)
select
    cs.id as crime_id,
    cs.date,
    cs.type,
    cs.location,
    cs.description,
    s.id as suspect_id,
    s.name as suspect_name,
    s.attire,
    s.scar,
    i.transcript
from crime_scene_cte cs
cross join suspect_cte s
inner join interview_cte i on s.id = i.suspect_id
;
/*
Results:

crime_id	date	    type    location	        suspect_id	
76	        19851120    theft   Blue Note Lounge    183

suspect_name	attire	    scar	    transcript
Vincent Malone	trench coat	left cheek	I wasn’t going to steal it, but I did.

description
A briefcase containing sensitive documents vanished. A witness reported a man
in a trench coat with a scar on his left cheek fleeing the scene.

Debug:

    select cs.*, s.*, i.*
    from crime_scene as cs
    full join suspects as s on cs.id = s.id
    full join interviews as i on s.id = i.suspect_id
    ;
*/
/*
===============================================================================
Case #002: The Stolen Sound

In the neon glow of 1980s Los Angeles, the West Hollywood Records store was
rocked by a daring theft. A prized vinyl record, worth over $10,000, vanished
during a busy evening, leaving the store owner desperate for answers. Vaguely
recalling the details, you know the incident occurred on July 15, 1983, at this
famous store. Your task is to track down the thief and bring them to justice.

Objectives
1. Retrieve the crime scene report for the record theft using the known date
   and location.
2. Retrieve witness records linked to that crime scene to obtain their clues.
3. Use the clues from the witnesses to find the suspect in the suspects table.
4. Retrieve the suspect’s interview transcript to confirm the confession.
*/
-- where cs.date == 19830715
select cs.*, w.*, s.*, i.*
from crime_scene as cs
full join witnesses as w on cs.id = w.crime_scene_id
full join suspects as s on cs.id = s.id
full join interviews as i on s.id = i.suspect_id
-- where (cs.date == 19830715 and location like "%West Hollywood Records%")
-- => red bandana + gold watch
where s.bandana_color == "red" and s.accessory == "gold watch"  -- => Rico Delgado
;
/*
id	date	type	location	description	id	crime_scene_id	clue	id	name	bandana_color	accessory	suspect_id	transcript
65	19830715	theft	West Hollywood Records	A prized vinyl record was stolen from the store during a busy evening.	28	65	I saw a man wearing a red bandana rushing out of the store.	65	Pedro Soto	brown	silver earrings	65	NULL
65	19830715	theft	West Hollywood Records	A prized vinyl record was stolen from the store during a busy evening.	75	65	The main thing I remember is that he had a distinctive gold watch on his wrist.	65	Pedro Soto	brown	silver earrings	65	NULL
*/
/*
	28	65	I saw a man wearing a red bandana rushing out of the store.                     	65	Pedro Soto	brown	silver earrings
	75	65	The main thing I remember is that he had a distinctive gold watch on his wrist. 	65	Pedro Soto	brown	silver earrings
*/
/* 
id	date	type	location	description	id	crime_scene_id	clue	id	name	bandana_color	accessory	suspect_id	transcript
35	19921221	theft	Fashion Boutique	A necklace worth thousands was stolen during a fashion show. A woman was seen leaving with it in her purse.	6	35	The suspect had a scar on his left cheek and was wearing a black cap.	35	Tony Ramirez	red	gold watch	35	I wasn't anywhere near West Hollywood Records that night.
44	20171003	theft	Car Dealership	NULL	3	44	NULL	44	Mickey Rivera	red	gold watch	44	I was busy with my music career; I have nothing to do with this theft.
44	20171003	theft	Car Dealership	NULL	9	44	NULL	44	Mickey Rivera	red	gold watch	44	I was busy with my music career; I have nothing to do with this theft.
97	20030512	theft	Gas Station	A cashier was robbed at gunpoint. The thief took the cash from the register.	NULL	NULL	NULL	97	Rico Delgado	red	gold watch	97	I couldn't help it. I snapped and took the record. 
*/


