-- =============================================
-- CCFT Vocab Brain — Batch 3
-- Extracted from: D7 (2 docs), D1 (5 docs), D2 (8 docs)
-- =============================================

insert into public.vocab_terms (term, definition, source, domains) values

-- =============================================
-- D7 — 211.full (weightlifting injury incidence)
-- =============================================
('Injury Incidence', 'Rate of injuries occurring per 1000 hours of training; weightlifting 2.4-3.3, powerlifting 1.0-4.4.', '211.full', array['D7']),
('Overuse Syndrome', 'Pain and functional limitations that appear gradually with athlete continuing training without adequate recovery.', '211.full', array['D7', 'D1']),
('Acute Injury', 'Sudden damaging event such as strains and lacerations occurring during a specific training incident.', '211.full', array['D7', 'D1']),
('Shoulder Injury (weightlifting)', 'Most common injury localization in both weightlifting and powerlifting; linked to extreme shoulder positions.', '211.full', array['D7', 'D1']),
('Low Back Injury', 'Common injury in weightlifters and powerlifters from high spinal compressive loading during barbell movements.', '211.full', array['D7', 'D1']),

-- =============================================
-- D7 — CFJ_Ray_Infections_Dec10
-- =============================================
('Cellulitis', 'Bacterial skin infection occurring when bacteria enter through skin breaks and multiply in surrounding tissue.', 'CFJ_Ray_Infections_Dec10', array['D7']),
('MRSA', 'Methicillin-resistant Staphylococcus aureus; antibiotic-resistant skin infection bacteria requiring specialized treatment.', 'CFJ_Ray_Infections_Dec10', array['D7']),
('Necrotizing Fasciitis', 'Life and limb-threatening infection spreading rapidly between soft tissue layers; requires immediate medical emergency response.', 'CFJ_Ray_Infections_Dec10', array['D7']),
('Tetanus Immunization', 'Vaccination updated every 10 years; recommended every 5 years after any significant laceration.', 'CFJ_Ray_Infections_Dec10', array['D7']),
('Bloodborne Pathogen', 'Disease agent transmitted through blood contact, including HIV and hepatitis; requires universal precautions.', 'CFJ_Ray_Infections_Dec10', array['D7']),
('Facility Disinfection', 'Using bleach or iodine-containing cleaners on equipment and surfaces to prevent infection transmission in gyms.', 'CFJ_Ray_Infections_Dec10', array['D7']),

-- =============================================
-- D1 — CFJ_2015_10_Squat_Long2
-- =============================================
('Butt Wink', 'Lumbar spine flexion occurring at the bottom of a squat due to insufficient hip mobility or hamstring length.', 'CFJ_2015_10_Squat_Long2', array['D1', 'D3', 'D4']),
('Valgus Collapse', 'Inward tracking of knees during squat; a motor control fault resulting from weak gluteal activation.', 'CFJ_2015_10_Squat_Long2', array['D1', 'D3', 'D4']),
('Squat Therapy', 'Corrective exercise using wall proximity and low box target to improve squat mechanics through progressive coaching cues.', 'CFJ_2015_10_Squat_Long2', array['D1', 'D3', 'D4']),
('Thoracic Spine Extension', 'Upper back extension capacity important for maintaining upright torso position in all squat variations.', 'CFJ_2015_10_Squat_Long2', array['D1', 'D3', 'D4']),

-- =============================================
-- D1 — CFJ_2015_11_Aging_Kilgore2
-- =============================================
('Performance Decay', 'Loss of fitness capacity over time; approximately 10% per decade until age 70, accelerating thereafter.', 'CFJ_2015_11_Aging_Kilgore2', array['D1', 'D5']),
('Repeated Bout Effect', 'Adaptation allowing the body to tolerate similar exercise with progressively less damage and soreness.', 'CFJ_2015_11_Aging_Kilgore2', array['D1']),
('Heavy Power Decay', 'Olympic lifting performance (snatch, clean and jerk) declines 25% by age 40 — twice the average decay rate.', 'CFJ_2015_11_Aging_Kilgore2', array['D1', 'D5']),

-- =============================================
-- D1 — CFJ_Webster_MuscleDamageSoreness
-- =============================================
('DOMS', 'Delayed Onset Muscle Soreness; appears 8+ hours post-exercise and peaks at 24-48 hours.', 'CFJ_Webster_MuscleDamageSoreness', array['D1']),
('Eccentric Action', 'Muscle lengthening under tension; the structurally most stressful muscle action and primary cause of DOMS.', 'CFJ_Webster_MuscleDamageSoreness', array['D1', 'D4']),
('Concentric Action', 'Muscle shortening generating tension; the lifting phase with less damage potential than eccentric action.', 'CFJ_Webster_MuscleDamageSoreness', array['D1', 'D4']),
('Isometric Action', 'Muscles generating tension with no change in length; holding a static position without movement.', 'CFJ_Webster_MuscleDamageSoreness', array['D1', 'D4']),
('Exertional Rhabdomyolysis', 'Rare condition from excessive muscle breakdown causing muscle proteins (myoglobin, creatine kinase) to enter the bloodstream; potentially fatal.', 'CFJ_Webster_MuscleDamageSoreness', array['D1', 'D7']),
('Creatine Kinase', 'Muscle enzyme spilled into the bloodstream after muscle membrane compromise; marker for muscle damage severity.', 'CFJ_Webster_MuscleDamageSoreness', array['D1']),
('Myoglobin', 'Oxygen-binding muscle protein released into bloodstream during muscle damage; excessive levels indicate rhabdomyolysis.', 'CFJ_Webster_MuscleDamageSoreness', array['D1']),
('Proprioceptive Function Loss', 'Reduced ability to sense limb position in space after muscle damage and eccentric overload.', 'CFJ_Webster_MuscleDamageSoreness', array['D1']),

-- =============================================
-- D1 — CFJ_Shrago_MentalGame
-- =============================================
('All-or-Nothing Thinking', 'Cognitive distortion treating a single mistake as complete failure with no gradations; limits athlete performance.', 'CFJ_Shrago_MentalGame', array['D1', 'D3']),
('T-CUP', 'Think Correctly Under Pressure; the ability to maintain confident, rational thinking under physical and psychological stress.', 'CFJ_Shrago_MentalGame', array['D1', 'D3', 'D4']),
('Mental Visualization', 'Creating a vivid mental image of successful performance before execution to improve actual outcome.', 'CFJ_Shrago_MentalGame', array['D1', 'D3']),
('Pre-Movement Routine', 'Linking a specific physical action with thoughts or images to build performance consistency under pressure.', 'CFJ_Shrago_MentalGame', array['D1', 'D3', 'D4']),
('Dissociation (mental)', 'Deliberately focusing the mind on an external object to draw attention away from pain or discomfort during exercise.', 'CFJ_Shrago_MentalGame', array['D1', 'D3']),
('Association (mental)', 'Focusing purely on the physical sensations of the body during exercise to maintain control and occupy the mind.', 'CFJ_Shrago_MentalGame', array['D1', 'D3']),

-- =============================================
-- D2 — 06_03_CF_Template
-- =============================================
('Three-Day On / One-Day Off', 'Standard CrossFit training frequency template: three consecutive days of training followed by one rest day.', '06_03_CF_Template', array['D2']),
('Modality (CrossFit)', 'Exercise classification system used in CrossFit programming: M (metabolic conditioning), G (gymnastics), W (weightlifting).', '06_03_CF_Template', array['D2']),
('Element Priority', 'Programming approach where specific fitness elements (strength, power, endurance) are selected and prioritized in sequence.', '06_03_CF_Template', array['D2']),
('Work-Recovery Character', 'The ratio and structure of work intervals to recovery intervals defining a workout''s training stimulus.', '06_03_CF_Template', array['D2']),

-- =============================================
-- D2 — 13_03_Benchmark_Workouts
-- =============================================
('The Girls (CrossFit)', 'A series of named benchmark workouts including Angie, Barbara, Chelsea, Diane, Elizabeth, and Fran used to measure fitness progress.', '13_03_Benchmark_Workouts', array['D2']),
('Fran', 'Benchmark workout: 21-15-9 thrusters (95 lbs) and pull-ups for time; tests high-intensity power output.', '13_03_Benchmark_Workouts', array['D2']),
('Angie', 'Benchmark workout: 100 pull-ups, 100 push-ups, 100 sit-ups, 100 squats for time; tests gymnastics capacity.', '13_03_Benchmark_Workouts', array['D2']),
('Diane', 'Benchmark workout: 21-15-9 deadlifts (225 lbs) and handstand push-ups for time; combines heavy load with gymnastics.', '13_03_Benchmark_Workouts', array['D2']),
('Hero Workouts', 'Named benchmark workouts honoring fallen military, law enforcement, and first responders; typically longer and more demanding than the Girls.', '13_03_Benchmark_Workouts', array['D2']),

-- =============================================
-- D2 — 31_05_fooling_with_fran
-- =============================================
('Work (physics)', 'Force multiplied by distance (foot-pounds); the fundamental unit quantifying the physical demand of a CrossFit workout.', '31_05_fooling_with_fran', array['D2']),
('Power (physics)', 'Work divided by time (watts or foot-pounds/second); the precise definition of workout intensity used in CrossFit.', '31_05_fooling_with_fran', array['D2']),
('Fran Isomers', 'Alternative rep schemes (1x45, 3x15, 5x9, 9x5) that distribute Fran''s same total volume differently, producing different power outputs.', '31_05_fooling_with_fran', array['D2']),

-- =============================================
-- D2 — 52_06_VO2_Not_Gold_Standard
-- =============================================
('Movement-Specific VO2max', 'VO2max values that vary based on the sport-specific movement pattern used during testing; not universal across modalities.', '52_06_VO2_Not_Gold_Standard', array['D2']),
('Wall-Ball Shot', 'A testing method for assessing metabolic capacity and power output specific to CrossFit movement demands.', '52_06_VO2_Not_Gold_Standard', array['D2']),

-- =============================================
-- D2 — 69_08_dissecting_fish
-- =============================================
('Fish Diagram', 'Graph showing the relationship between rate of adaptation, performance improvement, and training complexity over 0-72 months.', '69_08_dissecting_fish', array['D2']),
('Fitness Element Least Developed', 'The weakest component of an athlete''s fitness improves fastest under balanced CrossFit training; drives programming focus.', '69_08_dissecting_fish', array['D2']),

-- =============================================
-- D2 — 71_08_Human_Power_Output
-- =============================================
('Metabolic Power', 'Total energy expenditure measured in watts during physical activity; includes both mechanical work and heat production.', '71_08_Human_Power_Output', array['D2']),
('Mechanical Power', 'Actual external work output measured in watts; a fraction of total metabolic power.', '71_08_Human_Power_Output', array['D2']),
('Type I Muscle Fibers', 'Slow-twitch oxidative muscle fibers with high endurance and low power output capacity; recruited first.', '71_08_Human_Power_Output', array['D1', 'D2']),
('Type IIa Muscle Fibers', 'Intermediate fast-twitch muscle fibers with moderate power and endurance capacity; recruited for moderate-high intensity.', '71_08_Human_Power_Output', array['D1', 'D2']),
('Type IIb Muscle Fibers', 'Fast-twitch glycolytic muscle fibers with high power output and low endurance; recruited at maximal intensity.', '71_08_Human_Power_Output', array['D1', 'D2']),
('Motor Unit Recruitment', 'Activation of muscle fibers through the nervous system from smallest to largest (size principle) as intensity increases.', '71_08_Human_Power_Output', array['D1', 'D2']),

-- =============================================
-- D2 — CFJ_Kilgore_Adaptations
-- =============================================
('Alarm Stage', 'First stage of General Adaptation Syndrome where a novel stress triggers survival response and mobilizes resources.', 'CFJ_Kilgore_Adaptations', array['D2']),
('Resistance Stage', 'Second stage of General Adaptation Syndrome where the organism produces adaptive elements in response to continued stimulus.', 'CFJ_Kilgore_Adaptations', array['D2']),
('Exhaustion Stage', 'Third stage of General Adaptation Syndrome where failure to adapt occurs if stress continues without recovery.', 'CFJ_Kilgore_Adaptations', array['D2']),
('Super-compensation', 'Physiological principle where fitness restoration exceeds baseline after a training stimulus and adequate recovery.', 'CFJ_Kilgore_Adaptations', array['D2']),

-- =============================================
-- D2 — CFJ_Mason_Conjugate
-- =============================================
('Conjugate Method', 'Westside Barbell''s programming approach using frequent exercise rotation to prevent neural overtraining while developing maximal strength.', 'CFJ_Mason_Conjugate', array['D2']),
('Maximum-Effort Day', 'Training session focused on near-maximal loads (heavy singles, doubles, or triples) to develop absolute strength.', 'CFJ_Mason_Conjugate', array['D2']),
('Neural Overtraining', 'Excessive central nervous system fatigue from repeated high-intensity maximum-effort work without adequate rotation or recovery.', 'CFJ_Mason_Conjugate', array['D2']),
('72-Hour Recovery', 'Minimum rest period required between maximum-effort sessions to allow CNS recovery; a key conjugate programming rule.', 'CFJ_Mason_Conjugate', array['D2'])

on conflict (term) do nothing;
