-- =============================================
-- CCFT Brain — Full vocabulary seed (all 7 domains)
-- Replaces shallow seed batches with atomic brain nodes
-- Safe to re-run: all inserts use ON CONFLICT DO UPDATE
-- =============================================


-- CCFT Brain — D1 Screening & Ongoing Assessment
-- Seed file for vocab_terms table
-- Run in Supabase SQL Editor after schema migration (20260406000002)

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Aging and Performance',
  'Kilgore''s analysis of how aging affects physical capacity. Physical capacity inevitably declines with age, but fitness has dramatic effects on health and quality of life — 80-year-old athletes are stronger than non-athletes in their prime at 25. The rate and degree of decline is significantly modifiable through training. CrossFit''s definition of health as "fitness across age" directly applies, supporting both D1 ongoing assessment of aging athletes and D5 masters coaching.',
  'CFJ_2015_11_Aging_Kilgore2',
  '{"D1","D5"}',
  '{"Masters Quadrant","Sickness-Wellness-Fitness Continuum","Progressive Scaling"}',
  'Masters Quadrant'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Anatomy and Physiology Primer',
  'Kilgore''s comprehensive A&P reference for CrossFit trainers covering foundational anatomy and physiology needed to coach effectively, communicate professionally, and understand structures stressed during exercise. Includes skeleton types (axial and appendicular), bone anatomy, muscle structure and fiber types, joint mechanics, and cardiorespiratory anatomy. Key coaching takeaway: growth plates (epiphyseal plates) do NOT prevent youth from resistance training — properly supervised training is safe for youth.',
  'CFJ_Anatomy_Physiology_Primer',
  '{"D1","D3"}',
  '{"Spine Mechanics","Midline Stabilization","Power Zone"}',
  'D3 — Educating'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Cancer and Exercise',
  'CrossFit''s position on exercise and cancer: physical activity reduces cancer risk, and CrossFit-style training can be appropriate for cancer survivors with medical clearance. Exercise provides benefits across the Sickness-Wellness-Fitness Continuum even for those managing chronic disease. Coaches must work within scope of practice — medical clearance is required, movements modified as needed, with close monitoring for fatigue and tolerance. A CCFT trainer can work with cancer survivors but must recognize limitations and refer appropriately.',
  'CFJ_2016_06_Cancer-Saline4',
  '{"D6","D1"}',
  '{"Sickness-Wellness-Fitness Continuum","CCFT Scope of Practice","Progressive Scaling"}',
  'Sickness-Wellness-Fitness Continuum'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Coxofemoral Joint',
  'The true hip joint — a ball-and-socket articulation between the head of the femur and the acetabulum of the pelvis. The most important anatomic region in all athletic endeavors: the hip complex is the power-generation and transfer station that initiates and directs nearly all complex human movements. More stable but less mobile than the shoulder joint; this stability is what makes it powerful. Supported by a thick ligamentous capsule and the acetabular labrum, a wedge-shaped cartilage ring that deepens the socket.',
  'd3-hip-hollingsworth',
  '{"D3","D1"}',
  '{"Trunk","Extension","Muted Hip","Anterior Pelvic Tilt","Lumbo-Pelvic Rhythm","Gluteus Maximus","Iliopsoas"}',
  'Hip Joint'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'DOMS',
  'Delayed Onset Muscle Soreness — the muscle soreness that typically appears 24-72 hours after exercise, especially after novel movements or eccentric-heavy loading. DOMS is a normal physiological response, not necessarily an indicator of a good workout or a sign of injury. It occurs more frequently with new exercises, increased volume, or after a training break. Critical distinction from rhabdomyolysis: DOMS is localized and self-resolving; rhabdomyolysis involves systemic symptoms including dark urine, extreme swelling, and kidney risk.',
  'CFJ_Webster_MuscleDamageSoreness',
  '{"D1"}',
  '{"Rhabdomyolysis","Progressive Scaling"}',
  'D1 — Screening and Ongoing Assessment'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Diabetes and CrossFit',
  'CrossFit programming can be applied to athletes with diabetes through appropriate scaling and awareness of the condition''s metabolic demands. Coaches must understand how exercise affects blood glucose levels, recognize signs of hypoglycemia and hyperglycemia, and modify workout intensity and duration accordingly. CrossFit''s methodology — constantly varied functional movements at relative intensity — remains effective for diabetic athletes, but requires individualized attention to physiological state before, during, and after training. Scope of practice applies: coaches scale and monitor, not diagnose or manage medically.',
  'CFJ_Cochran_Diabetes',
  '{"D2","D1"}',
  '{"Progressive Scaling","Sickness-Wellness-Fitness Continuum","CCFT Scope of Practice"}',
  'Progressive Scaling'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Exertional Rhabdomyolysis Case',
  'Clinical case report documenting acute exertional compartment syndrome with rhabdomyolysis in a 17-year-old athlete, providing the evidence base for CrossFit''s emphasis on conservative onboarding and progressive intensity. Reinforces that rhabdomyolysis is a real medical emergency with documented consequences, not a theoretical risk. The correct coaching response: scale conservatively for new and returning athletes, recognize symptoms early, and refer to medical care immediately.',
  'amjcaserep-19-145',
  '{"D1","D7"}',
  '{"Rhabdomyolysis","Progressive Scaling","CCFT Scope of Practice"}',
  'Rhabdomyolysis'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Goal Setting',
  'Amundson''s framework for coaching the mental side of CrossFit. Goals must be specific, measurable, and time-bound. Coaches should help athletes set both process goals (improve mechanics) and outcome goals (hit a PR). Positive self-talk and mental preparation are trainable skills, not innate traits. Supports both D1 (identifying athlete fitness goals during screening and ongoing assessment) and D5 (leadership and athlete development).',
  'CFJ_Amundson_Goals',
  '{"D1","D5"}',
  '{"Deeper Side of Coaching","Pursuit of Excellence","Mental Toughness"}',
  'D5 — Leadership and Management'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Load Management and Return to Sport',
  'Load management uses the Acute:Chronic Workload Ratio (ACWR) to guide safe training progression and return-to-sport protocols. The ACWR compares an athlete''s recent training load (acute, typically one week) against their longer-term baseline (chronic, typically four weeks) — a ratio that spikes too high indicates too much too soon and elevated injury risk. Evidence-based return-to-sport protocols use this framework to progressively reintroduce training volume and intensity after injury or extended absence, ensuring capacity is built without exceeding tissue tolerance thresholds.',
  'ijspt-12-697',
  '{"D2","D1"}',
  '{"Progressive Scaling","Rhabdomyolysis"}',
  'Progressive Scaling'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Masters Quadrant',
  'A framework for categorizing and coaching aging athletes using four variables — Goals (Performance vs. Wellness), Age (Early Masters 40-54 vs. Late Masters 55+), Fitness Level (Fit vs. Deconditioned), and Injury State (Uninjured vs. Injured) — that combine to create 16 archetypes, each with specific coaching priorities. Key principles: resolving injury always takes highest priority; late masters athletes start at ~70% of Rx''d with an extra rest day per week; deconditioned masters require more conservative scaling than deconditioned younger athletes; wellness athletes need broad GPP stimulus, not competitive programming. CrossFit''s definition of health is "fitness across age."',
  'sme_masters_trainingguide',
  '{"D5","D1","D2"}',
  '{"Progressive Scaling","Relative Intensity","Sickness-Wellness-Fitness Continuum","Rhabdomyolysis"}',
  'D5 — Leadership and Management'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Measure of Man',
  'Explores the question of how to measure fitness and human performance, supporting CrossFit''s empirical approach — measurable, observable, repeatable data as the standard for assessing progress. Effective coaches quantify and track performance (times, loads, reps) to assess progress, inform programming, and motivate athletes. Subjective impressions are not sufficient; coaches must maintain objective records.',
  '71_08_Measure_of_Man',
  '{"D1","D2"}',
  '{"Work Capacity Across Broad Time and Modal Domains","Evidence-Based Fitness","Benchmark Workouts"}',
  'Work Capacity Across Broad Time and Modal Domains'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Mental Toughness',
  'The ability to continue according to plan in a way that is in line with your values even though negative thoughts and emotions are pulling you in another direction (Hermiz definition). CrossFit develops mental toughness mechanically: high-intensity anaerobic work triggers negative affect and pain signals, and consistently overcoming those moments builds a cognitive rule that persistence works. Mental toughness is trainable, not innate. The coach''s role: scale for success (beginners need to complete, not fail), progressively challenge, hold athletes to their plan, and teach cognitive defusion — observing negative thoughts without acting on them. Every completion strengthens mental toughness; every quit weakens it.',
  'CFJ_Shrago_MentalGame',
  '{"D1","D4","D5"}',
  '{"Goal Setting","Cognitive Defusion","General Adaptation Syndrome","Deeper Side of Coaching"}',
  'Goal Setting'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'PAR-Q',
  'The Physical Activity Readiness Questionnaire — an internationally recognized pre-participation screening tool used to identify individuals who may need medical clearance before beginning an exercise program. Evidence-based consensus (2011) found the original automatic physician-referral-for-any-yes approach overly conservative — qualified exercise professionals can clear many respondents through standardized follow-up. Critical principle: the risks of inactivity far outweigh the risks of physical activity, and age alone is not a valid barrier to exercise. A CCFT trainer uses the PAR-Q to determine readiness, not to diagnose; positive responses indicating conditions outside scope of practice require referral.',
  '2011-evidence-based-risk-assessment',
  '{"D1","D7"}',
  '{"CCFT Scope of Practice","Rhabdomyolysis"}',
  'D1 — Screening and Ongoing Assessment'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Performance Pregnancy Programming',
  'Addresses how to train high-performance pregnant athletes who wish to continue CrossFit throughout their pregnancy. Key principle: pregnancy is not an illness — well-trained athletes with medical clearance can maintain significant training loads with appropriate modifications by trimester. Coaches must understand the physiological changes of pregnancy (joint laxity, shifted center of gravity, cardiovascular changes) and scale movements accordingly while preserving stimulus intent. Sits at the intersection of D2 programming and D1 screening, requiring both programming knowledge and awareness of medical scope of practice.',
  'CFJ_Nitz_PerformancePregnancy',
  '{"D2","D1"}',
  '{"Pregnancy and CrossFit","Progressive Scaling","CCFT Scope of Practice"}',
  'Pregnancy and CrossFit'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Pregnancy Scaling Table',
  'Provides specific movement modifications for pregnant athletes organized by trimester. As pregnancy progresses, certain movements become contraindicated or require substitution — including barbell movements that contact the abdomen, supine positions after the first trimester, and range-of-motion adjustments for movements affected by joint laxity and a shifting center of gravity. Serves as a practical coaching reference that preserves training stimulus while respecting the physiological realities of each trimester.',
  'CFJ_Pregnancy_Christensen_Table_5',
  '{"D2","D1"}',
  '{"Pregnancy and CrossFit","Progressive Scaling","Scaling Strategies"}',
  'Pregnancy and CrossFit'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Pregnancy and CrossFit',
  'CrossFit''s position on training during pregnancy: with medical clearance, pregnant athletes can continue CrossFit training with appropriate modifications. Intensity and movements are scaled based on trimester, individual tolerance, and physician guidance. The coach''s role is to support the athlete within scope of practice — modifications are the coach''s domain, medical guidance is the physician''s domain, and the two must never conflict. Pregnancy is a special population requiring individualized scaling, not exclusion from training.',
  'CFJ_Pregnant_Perkins',
  '{"D1","D2"}',
  '{"Progressive Scaling","CCFT Scope of Practice","Masters Quadrant"}',
  'D1 — Screening and Ongoing Assessment'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Rhabdomyolysis',
  'A serious condition where muscle fibers break down and release myoglobin into the bloodstream, potentially causing kidney damage. Triggered by extreme exertion — especially in deconditioned individuals performing high-volume eccentric movements such as excessive GHD sit-ups. Symptoms appear 24-72 hours after exercise: extreme soreness, swelling, dark urine, and limited range of motion. CrossFit addresses rhabdomyolysis directly in trainer education. The correct coaching response is not to avoid intensity but to manage it intelligently: scale conservatively for new athletes, follow the mechanics-consistency-intensity sequence, recognize early warning signs, and refer to medical care without delay.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D1","D7"}',
  '{"Progressive Scaling","Mechanics-Consistency-Intensity","Intensity"}',
  'Safety'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Squat Mobility Assessment',
  'Zachary Long''s three-test framework for determining whether squat faults are caused by mobility limitations or motor control deficits. This distinction is critical for prescribing the correct intervention: mobility issues require stretching and mobilization, while motor control issues require practice and cueing. Treating a motor control problem with mobility work — or vice versa — wastes time and frustrates the athlete. Coaches use this assessment during screening and ongoing evaluation of movement capacity.',
  'CFJ_2015_10_Squat_Long2',
  '{"D1","D4"}',
  '{"Air Squat","Static and Dynamic Faults","Mechanics-Consistency-Intensity"}',
  'Air Squat'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Training Log',
  'Harrison''s case for using a training log as the primary tool for making CrossFit''s empirical approach actionable for individual athletes. A log creates a record that provides answers about programming effectiveness, recovery patterns, nutrition effects, and long-term progression — far beyond simply tracking times. Coaches should encourage athletes to log consistently; the data supports accountability, measurable progress tracking, and informed programming adjustments.',
  'CFJ_Log_Harrison',
  '{"D1"}',
  '{"Evidence-Based Fitness","Benchmark Workouts"}',
  'D1 — Screening and Ongoing Assessment'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

-- CCFT Brain — D2 Programming
-- Seed file for vocab_terms table
-- Run in Supabase SQL Editor after schema migration (20260406000002)

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  '10 General Physical Skills',
  'CrossFit''s first fitness model defines fitness as competence across 10 general physical skills: cardiovascular/respiratory endurance, stamina, strength, flexibility, power, speed, coordination, agility, balance, and accuracy. An athlete is as fit as they are competent in each skill. Four skills are trained through organic adaptation (endurance, stamina, strength, flexibility), four are practiced through neurological adaptation (coordination, agility, balance, accuracy), and two require both training and practice (power, speed).',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2"}',
  '{"Four Fitness Models","CrossFit Prescription","Work Capacity Across Broad Time and Modal Domains","Sickness-Wellness-Fitness Continuum"}',
  'Four Fitness Models'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Benchmark Workouts',
  'CrossFit workouts given female names that serve to measure and benchmark performance through repeated, irregular appearances — named after the NWS convention for naming storms. The original six (Angie, Barbara, Chelsea, Diane, Elizabeth, Fran) span a range of metabolic demands from aerobic continuous efforts to short phosphagen/glycolytic couplets. Only by repeating workouts can performance be confidently measured over time. Benchmarks exploit weaknesses: larger athletes struggle with gymnastics, smaller athletes with loads.',
  '13_03_Benchmark_Workouts',
  '{"D2"}',
  '{"Couplet","Triplet","Thruster","Pull-up","Task Priority vs Time Priority","Constant Variance"}',
  'CrossFit Programming'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Cardiovascular/Respiratory Endurance',
  'The ability of body systems to gather, process, and deliver oxygen. One of the four trained skills — developed through measurable organic changes in the cardiovascular and respiratory systems. Improved through sustained monostructural work and high-rep metabolic conditioning. Distinct from stamina: endurance governs oxygen delivery, while stamina governs energy utilization. CrossFit develops this alongside all other skills rather than in isolation.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2"}',
  '{"10 General Physical Skills","Oxidative Pathway","Interval Training","Stamina"}',
  '10 General Physical Skills'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Completion Window',
  'A forecasted time range (for task-priority workouts) or total round/rep count (for time-priority workouts) that the coach establishes before class to guide scaling decisions. Armed with a completion window, the coach can quickly determine whether an athlete''s scaled version will produce the intended stimulus. If scaled athletes finish drastically faster or slower than the window, it signals a scaling error.',
  'CFJ_2015_10_Scaling_Gordon_4',
  '{"D2","D5"}',
  '{"Scaling Strategies","Task Priority vs Time Priority","Relative Intensity"}',
  'Scaling Strategies'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Conjugate Method',
  'Louie Simmons'' original training system from Westside Barbell that simultaneously develops maximal strength, dynamic effort (speed-strength), and repetition effort (muscular endurance) by rotating exercises frequently to avoid accommodation. Simmons'' system uses max effort days with near-maximal loads on varied movements and dynamic effort days with submaximal loads moved at maximum speed. CrossFit draws on conjugate principles in its commitment to constant variance — regularly rotating movements, loads, and time domains produces broader adaptation and avoids the plateaus inherent in repetitive programming.',
  'CFJ_Simmons_Conjugate',
  '{"D2"}',
  '{"Conjugate Periodization","Constant Variance","Intensity"}',
  'Conjugate Periodization'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Conjugate Periodization',
  'A programming strategy that rotates movement variations frequently to avoid accommodation — the diminishing returns that occur when the body adapts to a repeated stimulus. In CrossFit''s application, conjugate principles align naturally with the methodology''s emphasis on constant variance: cycling through squat variations, pressing movements, pulling patterns, and metabolic conditioning modalities prevents staleness while continuing to develop broad fitness. This approach contrasts with traditional linear periodization, which focuses on one quality at a time and risks detraining others.',
  'CFJ_Mason_Conjugate',
  '{"D2"}',
  '{"Constant Variance","Three-Day On One-Day Off Template","Three Modalities"}',
  'Constant Variance'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Constant Variance',
  'The "constantly varied" element of CrossFit''s prescription. There is no ideal routine — the chief value of any routine lies in abandoning it for another. CrossFit programs vary movements, modalities, time domains, loads, rep schemes, and rest intervals to expand the margins of exposure as broadly as function and capacity allow. Athletes are weakest at the margins of their exposure; variance is not randomness but planned variety designed to avoid specialization and prepare for any physical contingency.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2"}',
  '{"CrossFit Prescription","Hopper Model","Fringe Athletes","Three-Day On One-Day Off Template"}',
  'CrossFit Prescription'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Couplet',
  'A CrossFit workout combining two movements. Along with triplets, couplets are the short, intense workouts that epitomize CrossFit programming — described by Glassman as the main course of training, not the seasoning. A well-designed couplet tests specific fitness capacities while maintaining high intensity, typically emphasizing the phosphagen or glycolytic pathways.',
  'Virtuosity (Glassman, CFJ August 2005)',
  '{"D2","D3"}',
  '{"Triplet","CrossFit Programming","Virtuosity","Benchmark Workouts","Fran","Intensity"}',
  'CrossFit Programming'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'CrossFit Adaptations',
  'CrossFit training produces neuroendocrine, metabolic, and structural adaptations that collectively improve capacity across all ten general physical skills. Neuroendocrine adaptations include favorable hormonal responses — increased growth hormone, testosterone, and insulin-like growth factor — triggered by high-intensity functional movements. Metabolic adaptations improve efficient utilization of multiple energy pathways; structural adaptations include increased bone density, muscle hypertrophy, and connective tissue strengthening. These adaptations are dose-dependent on intensity, which is why CrossFit prioritizes intensity as the independent variable most correlated with results.',
  'CFJ_Kilgore_Adaptations',
  '{"D2"}',
  '{"Neuroendocrine Response","10 General Physical Skills","Intensity"}',
  'Intensity'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Fran Analysis',
  'Fran (21-15-9 thrusters at 95/65 lb and pull-ups) is one of CrossFit''s most diagnostic benchmarks, designed to test capacity across a short, high-intensity time domain. Analysis reveals critical insights about pacing strategy, the interplay between metabolic conditioning and strength, and the physiological cost of unbroken versus broken sets. What Fran exposes — power output sustainability, lactate tolerance, and mental toughness — makes it the benchmark coaches return to most for measuring athlete progress.',
  '31_05_fooling_with_fran',
  '{"D2"}',
  '{"Benchmark Workouts","Thruster","Pull-up","Intensity"}',
  'Benchmark Workouts'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'General Adaptation Syndrome',
  'Hans Selye''s 1936 theory explaining how the body responds to stress: the organism goes through a programmed series of physiological responses and adaptations to ensure survival when exposed to the same or similar stress later. The critical CrossFit application: a disruption of homeostasis must occur in a physiological system for adaptation and fitness improvement to occur in that same system. This is the theoretical foundation for why conventional long-slow-distance aerobic training fails to improve VO2max in trained individuals — it never disrupts oxygen homeostasis.',
  'd3-aerobic-paradox',
  '{"D2","D3"}',
  '{"Homeostatic Disruption","Long-Slow Distance","Interval Training","VO2 Max Critique","Aerobic Paradox"}',
  null
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Glycolytic Pathway',
  'The energy system that dominates activity lasting approximately 10 seconds to several minutes. Breaks down glucose or glycogen without oxygen to produce ATP, generating lactic acid as a byproduct. This pathway fuels most CrossFit workout efforts — the "burn" athletes feel during high-rep sets or moderate-duration WODs is largely glycolytic. It produces moderate power output but cannot sustain maximum effort. CrossFit''s emphasis on varied time domains ensures athletes develop this pathway alongside the phosphagen and oxidative systems.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2"}',
  '{"Phosphagen Pathway","Oxidative Pathway","Four Fitness Models","Intensity"}',
  'Four Fitness Models'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Homeostatic Disruption',
  'The required stimulus for physiological adaptation. Per Selye''s General Adaptation Syndrome, a disruption of homeostasis must occur in a specific physiological system for adaptation to occur in that system. Long-slow-distance exercise at 70% VO2max does not disrupt oxygen homeostasis — oxygen supply meets demand — so no VO2max adaptation occurs in trained individuals. Only training at 150-250% VO2max creates the disruption needed to drive VO2max gain. CrossFit''s high-intensity methodology creates homeostatic disruption across multiple systems simultaneously.',
  'd3-aerobic-paradox',
  '{"D2","D3"}',
  '{"General Adaptation Syndrome","Long-Slow Distance","Interval Training","VO2 Max Critique","Aerobic Paradox","Intensity"}',
  'General Adaptation Syndrome'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Hopper Hierarchy',
  'A deeper analysis of the Hopper Model fitness test, proposing that a truly fit athlete should perform well on any randomly selected physical task. Dissecting the hierarchy reveals that certain physical skills — cardiovascular endurance and stamina — form a foundation upon which strength, power, and speed are built. This layered understanding helps coaches prioritize programming and explains why some athletes excel across broad domains while others show predictable gaps.',
  '69_08_dissecting_fish',
  '{"D2"}',
  '{"Hopper Model","Four Fitness Models","10 General Physical Skills"}',
  'Hopper Model'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Hopper Model',
  'CrossFit''s second fitness model. Imagine every conceivable physical challenge written on a card and placed in a hopper — the fittest person is the one who performs well at any task drawn randomly. This model defines fitness as competence across any and all physical demands, including those that are unknown and unknowable. It is the logical extension of CrossFit''s commitment to broad, general, inclusive fitness and justifies the "constantly varied" element of the prescription. Specialization is a liability because the hopper may draw any challenge.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2"}',
  '{"Four Fitness Models","Constant Variance","10 General Physical Skills","Fringe Athletes","Work Capacity Across Broad Time and Modal Domains"}',
  'Four Fitness Models'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Human Power Output',
  'Power output in CrossFit is defined as force multiplied by distance divided by time (P = F × D / T), providing a measurable, objective metric for exercise intensity. Power output is the single most correlated variable with favorable adaptation in CrossFit training — the athlete who produces more power across a workout is fitter by CrossFit''s definition. Measuring power output allows coaches to quantify intensity, track progress over time, and compare performance across athletes and workouts in an evidence-based manner.',
  '71_08_Human_Power_Output',
  '{"D2"}',
  '{"Intensity","Work Capacity Across Broad Time and Modal Domains","Evidence-Based Fitness"}',
  'Intensity'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Intensity',
  'In CrossFit, intensity is defined exactly as power: force times distance divided by time. It is the independent variable most commonly associated with maximizing the rate of return of favorable adaptation — increases in strength, performance, muscle mass, and bone density all arise in proportion to intensity. CrossFit distinguishes between absolute intensity (measurable power output) and relative intensity (how hard an effort feels relative to an individual''s capacity). Coaches scale workouts to achieve appropriate relative intensity while preserving the intended stimulus.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2","D4"}',
  '{"CrossFit Prescription","Functional Movement","Mechanics-Consistency-Intensity","Progressive Scaling","Neuroendocrine Response","Work Capacity Across Broad Time and Modal Domains"}',
  'CrossFit Prescription'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Interval Training',
  'Alternating periods of high-intensity work with periods of rest or lower-intensity recovery. CrossFit favors interval training over long, steady-state aerobic work because intervals develop both anaerobic and aerobic capacity simultaneously while producing greater power output. Research (including Tabata''s) demonstrates that interval protocols improve VO2 max comparably or superiorly to steady-state training while also developing anaerobic power that steady-state training cannot. CrossFit uses varied interval structures from Tabata (20s on/10s off) to longer work-rest ratios.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D2","D3"}',
  '{"Tabata Interval","Intensity","Glycolytic Pathway","Oxidative Pathway"}',
  'CrossFit Methodology'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Linear Progression',
  'A strength programming strategy for novice athletes where load is increased session to session in small, consistent increments until progress stalls. This approach exploits the rapid neurological and muscular adaptations available to beginners, who can add weight to the bar every training session because they have not yet approached their genetic potential. Linear progression is appropriate early in an athlete''s development and aligns with the mechanics-consistency-intensity hierarchy — the athlete must first demonstrate sound mechanics before load is systematically increased.',
  'CFJ_Mason_Linear',
  '{"D2"}',
  '{"Mechanics-Consistency-Intensity","Progressive Scaling","Intensity"}',
  'Mechanics-Consistency-Intensity'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Load Management and Return to Sport',
  'Load management uses the Acute:Chronic Workload Ratio (ACWR) to guide safe training progression and return-to-sport protocols. The ACWR compares an athlete''s recent training load (acute, typically one week) against their longer-term baseline (chronic, typically four weeks) — a ratio that spikes too high indicates too much too soon, increasing injury risk. Evidence-based return-to-sport protocols use this framework to progressively reintroduce training volume and intensity after injury or extended absence, ensuring the athlete builds capacity without exceeding tissue tolerance thresholds.',
  'ijspt-12-697',
  '{"D2","D1"}',
  '{"Progressive Scaling","D1 Screening","Rhabdomyolysis"}',
  'Progressive Scaling'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Long-Slow Distance',
  'A training method consisting of 60-120 minutes of continuous exercise at approximately 70% VO2max. In trained individuals it fails to improve VO2max because it does not disrupt oxygen homeostasis — the athlete can run longer but not faster. Long-slow-distance improves oxidative energy substrate storage but not oxygen utilization capacity. The only scenarios where LSD drives VO2max adaptation are in beginners or at altitude; in trained individuals, 70% effort is appropriate only for recovery days.',
  'd3-aerobic-paradox',
  '{"D2","D3"}',
  '{"Interval Training","Homeostatic Disruption","General Adaptation Syndrome","VO2 Max Critique","Aerobic Paradox"}',
  null
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Oxidative Pathway',
  'The energy system that dominates activity lasting longer than several minutes, using oxygen to metabolize fats and carbohydrates for sustained, lower-power output. Activities greater than approximately 90 seconds begin relying primarily on the oxidative pathway. CrossFit''s position is that excessive aerobic training develops this pathway at the expense of the phosphagen and glycolytic systems, producing a narrow fitness inconsistent with broad physical competence. CrossFit develops aerobic capacity through varied time domains rather than steady-state-only training.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2"}',
  '{"Phosphagen Pathway","Glycolytic Pathway","Four Fitness Models","Fringe Athletes"}',
  'Four Fitness Models'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Phosphagen Pathway',
  'The energy system that dominates activity lasting less than approximately 10 seconds, using stored ATP and creatine phosphate for immediate, high-power output without oxygen. This is the dominant pathway for max-effort lifts, short sprints, and explosive movements. It depletes rapidly and requires full rest (2-5 minutes) for recovery. CrossFit programs tap this pathway with heavy singles, short sprints, and explosive efforts. It is one of the three metabolic pathways in CrossFit''s third fitness model.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2"}',
  '{"Glycolytic Pathway","Oxidative Pathway","Four Fitness Models","Intensity"}',
  'Four Fitness Models'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Power',
  'The ability of a muscular unit, or combination of muscular units, to apply maximum force in minimum time. One of two skills that are both trained AND practiced — requires both organic adaptation (muscle/tendon capacity) and neurological adaptation (rate of force development, motor unit recruitment speed). Power is the "undisputed king of performance" in CrossFit, and intensity is defined exactly as power (force × distance / time). The Olympic lifts are the supreme developers of power because they demand maximum force at maximum speed.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2"}',
  '{"10 General Physical Skills","Intensity","Strength","Speed","Snatch","Clean"}',
  '10 General Physical Skills'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Progressive Scaling',
  'The process of adjusting a workout''s load, volume, movement complexity, or time domain to match an individual athlete''s current capacity while preserving the intended stimulus. Scaling is not a concession — it is the mechanism by which CrossFit''s program is universally applicable. A properly scaled workout delivers the same relative intensity and stimulus as the prescribed version. The coach''s skill is in choosing the right scaling option to preserve the workout''s intent, not merely to make it easier.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2","D4"}',
  '{"Mechanics-Consistency-Intensity","Relative Intensity","Intensity","Rhabdomyolysis"}',
  'Mechanics-Consistency-Intensity'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Relative Intensity',
  'How hard an effort is relative to an individual athlete''s capacity, as distinguished from absolute intensity (measurable power output). A 95-lb thruster is high relative intensity for a novice but low for an elite athlete. Coaches use relative intensity to scale workouts so that every athlete experiences a comparable stimulus regardless of absolute capacity — matching the intended feel of the workout (e.g., "this should feel like a sprint" or "this should take 8-12 minutes") by adjusting load, reps, or movement complexity.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2","D4"}',
  '{"Intensity","Progressive Scaling","Mechanics-Consistency-Intensity","Threshold Training"}',
  'Intensity'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Scaling Strategies',
  'Jeremy Gordon''s (CF-L4) framework for scaling CrossFit workouts to preserve three primary stimuli: time domain (desired metabolic pathway matched via completion window), movement pattern (functional movement type preserved within the same family), and complexity (neurological demand scaled within the same movement family). The four elements coaches adjust are load, range of motion, repetitions/rounds, and movement substitution. The cardinal rule: scale to preserve the stimulus, not just to make the workout easier — and never increase volume to compensate for reduced movement complexity.',
  'CFJ_2015_10_Scaling_Gordon_4',
  '{"D2","D4"}',
  '{"Progressive Scaling","Relative Intensity","Mechanics-Consistency-Intensity","Rhabdomyolysis","Task Priority vs Time Priority","Benchmark Workouts"}',
  'Progressive Scaling'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Single-Element Days',
  'Days 1, 5, and 9 of the CrossFit programming template, each using a single modality with element priority — the focus is on the element itself rather than time or task completion. Day 1 (M): long, slow distance (e.g., Run 10K). Day 5 (G): single high-skill practice session (e.g., handstands for 45 minutes). Day 9 (W): heavy single lift (e.g., Deadlift 5-3-3-2-2-2-1-1-1). Recovery is not a limiting factor on these days; quality of the single element is the priority.',
  '06_03_CF_Template',
  '{"D2"}',
  '{"Three Modalities","Task Priority vs Time Priority","Couplet","Triplet"}',
  'Three-Day On One-Day Off Template'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Speed',
  'The ability to minimize the time cycle of a repeated movement. One of two skills that are both trained AND practiced — requires organic adaptation (fast-twitch fiber development) and neurological adaptation (motor pattern efficiency, rate coding). Speed is developed through sprint work, explosive movements, and high-velocity training. Along with power, speed is the only skill in the 10 General Physical Skills that requires both training and practice; the other eight are exclusively one or the other.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2"}',
  '{"10 General Physical Skills","Power","Intensity","Phosphagen Pathway"}',
  '10 General Physical Skills'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Stamina',
  'The ability of body systems to process, deliver, store, and utilize energy. One of the four trained skills. Distinct from cardiovascular endurance: endurance governs oxygen delivery, stamina governs energy utilization. Developed through repeated exposure to metabolic demand, high-rep workouts, and sustained efforts that challenge the body''s energy systems through measurable organic changes.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2"}',
  '{"10 General Physical Skills","Cardiovascular Respiratory Endurance","Glycolytic Pathway","Intensity"}',
  '10 General Physical Skills'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Stimulus Intent',
  'The principle that the workout is the tool, not the goal — the coach''s job is to deliver a specific physiological stimulus, not to rigidly enforce a prescribed workout. When a coach understands the intended stimulus (short and fast, long and grinding, heavy and slow), they can scale movements, loads, and time domains to ensure every athlete receives that stimulus regardless of ability level. This concept separates effective coaching from mere workout delivery: movements are interchangeable, but the stimulus must be preserved.',
  'CFJ_Platek_IWCABTAMD_March2011',
  '{"D2"}',
  '{"Relative Intensity","Progressive Scaling","Constant Variance"}',
  'Relative Intensity'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Strength',
  'The ability of a muscular unit, or combination of muscular units, to apply force. One of the four trained skills — developed through heavy loading (deadlifts, squats, presses, Olympic lifts) producing measurable organic changes including muscle hypertrophy and neural recruitment. Strength is foundational to athletic performance; CrossFit develops it through compound, functional movements rather than isolation exercises. Distinct from power, which adds the speed dimension.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2"}',
  '{"10 General Physical Skills","Power Zone","Deadlift","Air Squat","Power"}',
  '10 General Physical Skills'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Tabata Interval',
  'A specific interval protocol: 20 seconds of maximum effort followed by 10 seconds of rest, repeated for 8 rounds (4 minutes total). Named after Dr. Izumi Tabata, whose research demonstrated this protocol improved both anaerobic and aerobic capacity simultaneously — supporting CrossFit''s approach to metabolic conditioning over long steady-state cardio. The Tabata interval is used in CrossFit programming as a standalone workout format (e.g., "Tabata Something Else") and represents a key evidence base for short, intense interval training.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D2","D3"}',
  '{"Intensity","Glycolytic Pathway","Constant Variance","Three-Day On One-Day Off Template"}',
  'Interval Training'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Task Priority vs Time Priority',
  'Two primary workout structures in CrossFit programming. Task priority ("for time") prescribes a fixed amount of work — the athlete completes it as fast as possible. Time priority ("AMRAP") prescribes a fixed time — the athlete completes as much work as possible. Each creates a different stimulus: task priority rewards speed and intensity; time priority rewards pacing and sustained output. Coaches choose between them based on the intended stimulus and which metabolic pathway they want to emphasize.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D2","D3"}',
  '{"Intensity","Constant Variance","Progressive Scaling","Three-Day On One-Day Off Template"}',
  'CrossFit Prescription'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Team Workouts',
  'Structured training sessions where two or more athletes share the workload, alternating or partitioning tasks to complete a common goal. They allow for natural scaling within the group because athletes self-select intensity based on their capacity relative to their partner. Team workouts teach cooperation, reinforce community, and maintain the social bonds that distinguish CrossFit from individual training programs.',
  '14_03_Team_Workouts',
  '{"D2"}',
  '{"Benchmark Workouts","Constant Variance","D2 Programming"}',
  'D2 Programming'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Theoretical Hierarchy of Development',
  'CrossFit''s developmental pyramid establishes the foundational order for building an athlete. From base to apex: Nutrition, Metabolic Conditioning, Gymnastics, Weightlifting, and Sport. Each level builds on the one below — without proper nutrition, metabolic conditioning cannot be optimized, and so on up the chain. The pyramid informs both long-term athlete development and daily class programming structure: nutrition is the foundation of fitness, and sport is the expression of fitness built on all lower levels.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2"}',
  '{"World-Class Fitness in 100 Words","CrossFit Prescription","Zone Diet","10 General Physical Skills","Mechanics-Consistency-Intensity"}',
  'CrossFit Methodology'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Three Modalities',
  'CrossFit''s programming template organizes exercises into three modalities: M (Metabolic Conditioning — monostructural cardio: run, bike, row, jump rope), G (Gymnastics — bodyweight exercises: air squats, pull-ups, push-ups, handstand push-ups, muscle-ups), and W (Weightlifting — powerlifting and Olympic lifts: deadlifts, cleans, presses, snatch). Workout days combine 1, 2, or 3 modalities — single-modality days focus on element priority, couplets are task priority, triplets are time priority.',
  '06_03_CF_Template',
  '{"D2","D3"}',
  '{"Three-Day On One-Day Off Template","Task Priority vs Time Priority","Couplet","Triplet","Constant Variance"}',
  'CrossFit Methodology'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Three-Day On One-Day Off Template',
  'CrossFit''s foundational programming template: three consecutive days of training followed by one rest day, cycling continuously regardless of the calendar week. Programming within this template varies modality, time domain, and loading across each cycle. The rest day is essential for recovery and adaptation. This template supports the constantly varied prescription by preventing weekly pattern formation — the cycle does not align to a seven-day week intentionally.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D2","D3"}',
  '{"Constant Variance","CrossFit Prescription","Task Priority vs Time Priority","Couplet","Triplet"}',
  'CrossFit Methodology'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Threshold Training',
  'The concept that training at the threshold of discomfort — where intensity is high enough to challenge but not so high as to break mechanics — produces optimal adaptation. CrossFit coaches manage the threshold by manipulating load, speed, and complexity relative to the athlete''s capacity. Training below threshold produces minimal adaptation; training far above threshold degrades mechanics and increases injury risk. The coach''s role is to find and maintain the athlete at their threshold through appropriate scaling and cueing.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2"}',
  '{"Intensity","Mechanics-Consistency-Intensity","Progressive Scaling","Relative Intensity"}',
  'Intensity'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Triplet',
  'A CrossFit workout combining three movements. Along with couplets, triplets are the short, intense workouts that epitomize CrossFit programming according to Glassman — the main course of training. Adding a third movement increases complexity and typically extends the time domain slightly while testing broader fitness capacity.',
  'Virtuosity (Glassman, CFJ August 2005)',
  '{"D2","D3"}',
  '{"Couplet","CrossFit Programming","Virtuosity","Benchmark Workouts","Intensity"}',
  'CrossFit Programming'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'VO2 Max Critique',
  'CrossFit argues that VO2 max is not the gold standard for measuring fitness because it captures only one narrow dimension of aerobic capacity. An athlete with a high VO2 max may lack strength, power, flexibility, or skill — domains equally critical to real-world performance. CrossFit''s alternative measure, work capacity across broad time and modal domains, provides a more comprehensive and falsifiable definition of fitness accounting for all ten general physical skills, multiple time domains, and varied movement patterns.',
  '52_06_VO2_Not_Gold_Standard',
  '{"D2"}',
  '{"Work Capacity Across Broad Time and Modal Domains","Four Fitness Models","Fringe Athletes"}',
  'Four Fitness Models'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Volume Programming',
  'Addresses when and how experienced athletes can safely add training volume beyond the standard CrossFit prescription. More volume is not always better — adding volume without maintaining intensity dilutes the stimulus and can lead to overtraining, injury, or diminished returns. Increased volume should only be considered after an athlete has demonstrated consistent mechanics and the ability to sustain high relative intensity, and it must be introduced incrementally with attention to recovery.',
  'CFJ_2016_02_Volume_Hobart',
  '{"D2"}',
  '{"Progressive Scaling","Intensity","Mechanics-Consistency-Intensity","Three-Day On One-Day Off Template"}',
  'D2 Programming'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Work Capacity Across Broad Time and Modal Domains',
  'CrossFit''s operational definition of fitness. The fittest individual has the greatest work capacity across broad time and modal domains — performing well across short, medium, and long time durations and across all movement modalities (weightlifting, gymnastics, monostructural). Graphically, fitness is the area under a curve plotting power output against time; the greater the area, the fitter the athlete. This definition makes fitness measurable, observable, and repeatable, and explains why specialization reduces fitness by narrowing the area under the curve.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D2"}',
  '{"Four Fitness Models","Hopper Model","Intensity","10 General Physical Skills","Evidence-Based Fitness"}',
  'Four Fitness Models'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

-- CCFT Brain Seed: D3 — Educating
-- Sources: Virtuosity.pdf + CFJ_English_Level1_TrainingGuide.pdf
-- Generated: 2026-04-06
-- Total terms: 59 (8 Virtuosity + 51 L1 Training Guide)
-- Run in Supabase SQL Editor (project: eatfwfjxrosdewloozta)

-- ============================================================
-- VIRTUOSITY.PDF (8 terms)
-- ============================================================

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Virtuosity',
  'Performing the common uncommonly well. In gymnastics, virtuosity earns the last three-tenths of a point toward a perfect 10.0. In CrossFit coaching, it means mastering fundamental movements before advancing to complex ones.',
  'Virtuosity (Glassman, CFJ August 2005)',
  '{"D3", "D4"}',
  '{"Novice''s Curse", "Fundamentals", "Movement Progression"}',
  'Coaching Philosophy'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Novice''s Curse',
  'The tendency of new trainers to advance athletes to complex movements before mastering fundamentals, sacrificing virtuosity for novelty.',
  'Virtuosity (Glassman, CFJ August 2005)',
  '{"D3"}',
  '{"Virtuosity", "Fundamentals", "Mechanics-Consistency-Intensity"}',
  'Virtuosity'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Fundamentals',
  'The basic movements and positions forming the foundation of all CrossFit training. Mastery is the prerequisite for advancing to complex or loaded movements.',
  'Virtuosity (Glassman, CFJ August 2005)',
  '{"D3", "D4"}',
  '{"Virtuosity", "Movement Progression", "Mechanics-Consistency-Intensity"}',
  'Virtuosity'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Movement Progression',
  'Structured sequence for teaching CrossFit movements, progressing from simple to complex and unloaded to loaded only after demonstrating mastery at each stage.',
  'Virtuosity (Glassman, CFJ August 2005)',
  '{"D3", "D4"}',
  '{"Virtuosity", "Fundamentals", "Mechanics-Consistency-Intensity"}',
  'Virtuosity'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Risk (Gymnastics Scoring)',
  'In gymnastics, one of three elements contributing to a perfect score. Represents difficulty — the more difficult the skill, the higher the potential score.',
  'Virtuosity (Glassman, CFJ August 2005)',
  '{"D3"}',
  '{"Virtuosity", "Originality (Gymnastics Scoring)"}',
  'Virtuosity'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Originality (Gymnastics Scoring)',
  'In gymnastics, one of three elements contributing to a perfect score. Represents novelty and creativity in movement execution.',
  'Virtuosity (Glassman, CFJ August 2005)',
  '{"D3"}',
  '{"Virtuosity", "Risk (Gymnastics Scoring)"}',
  'Virtuosity'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Couplet',
  'Workout structure using two movements, typically pairing weightlifting with gymnastics or monostructural to create complementary demand.',
  'Virtuosity (Glassman, CFJ August 2005)',
  '{"D2", "D3"}',
  '{"Triplet", "Constant Variance", "Three-Day On One-Day Off Template"}',
  'CrossFit Programming'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Triplet',
  'Workout structure using three movements, typically combining weightlifting, gymnastics, and monostructural elements.',
  'Virtuosity (Glassman, CFJ August 2005)',
  '{"D2", "D3"}',
  '{"Couplet", "Constant Variance", "Three-Day On One-Day Off Template"}',
  'CrossFit Programming'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- ============================================================
-- L1 TRAINING GUIDE — FRAMEWORKS + CONCEPTS + METABOLIC + MOVEMENTS (51 terms)
-- ============================================================

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('CrossFit Methodology', 'The overarching system: aims (broad, general, inclusive fitness), prescription (CVHIFM), implementation (Sport of Fitness), adaptations (measurable improvement). Empirically driven, clinically tested, community developed.', 'CFJ_English_Level1_TrainingGuide', '{"D3"}', '{"CrossFit Prescription", "Evidence-Based Fitness", "Sport of Fitness", "Four Fitness Models", "10 General Physical Skills"}', null) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('CrossFit Prescription', 'Constantly varied, high-intensity functional movement. Functional movements are universal motor recruitment patterns performed in a wave of contraction from core to extremity.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Functional Movement", "Intensity", "Constant Variance", "Core to Extremity", "10 General Physical Skills"}', 'CrossFit Methodology') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('10 General Physical Skills', 'First fitness model: cardiovascular/respiratory endurance, stamina, strength, flexibility, power, speed, coordination, agility, balance, accuracy. Four trained, four practiced, two both.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D2"}', '{"Four Fitness Models", "CrossFit Prescription", "Work Capacity Across Broad Time and Modal Domains"}', 'Four Fitness Models') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Four Fitness Models', 'CrossFit defines fitness through four models: 10 General Physical Skills, Hopper Model, three metabolic pathways, Sickness-Wellness-Fitness Continuum.', 'CFJ_English_Level1_TrainingGuide', '{"D3"}', '{"10 General Physical Skills", "Hopper Model", "Phosphagen Pathway", "Glycolytic Pathway", "Oxidative Pathway", "Sickness-Wellness-Fitness Continuum"}', 'CrossFit Methodology') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Sickness-Wellness-Fitness Continuum', 'Health markers on a continuum from sickness (pathological) to wellness (normal) to fitness (better than normal). CrossFit''s view: fitness and health are the same thing.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D6"}', '{"Four Fitness Models", "10 General Physical Skills", "World-Class Fitness in 100 Words"}', 'Four Fitness Models') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('World-Class Fitness in 100 Words', 'Glassman''s canonical summary: eat meat/vegetables/nuts/seeds/fruit, little starch, no sugar. Keep intake supporting exercise not body fat. Practice major lifts, master gymnastics, run/bike/row/swim hard and fast.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D6"}', '{"CrossFit Prescription", "Zone Diet", "10 General Physical Skills", "Constant Variance"}', 'CrossFit Methodology') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Theoretical Hierarchy of Development', 'Developmental pyramid base to apex: Nutrition, Metabolic Conditioning, Gymnastics, Weightlifting, Sport. Each level builds on the one below.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D2"}', '{"World-Class Fitness in 100 Words", "Zone Diet", "10 General Physical Skills", "Mechanics-Consistency-Intensity"}', 'CrossFit Methodology') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Evidence-Based Fitness', 'CrossFit''s methodology is entirely empirical. Meaningful statements about safety, efficacy, and efficiency supported only by measurable, observable, repeatable data.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D7"}', '{"CrossFit Methodology", "Sport of Fitness", "Work Capacity Across Broad Time and Modal Domains"}', 'CrossFit Methodology') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Mechanics-Consistency-Intensity', 'Progression model: demonstrate proper mechanics, then consistency, before adding intensity. An ongoing coaching framework, not a one-time gate.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Virtuosity", "Fundamentals", "Progressive Scaling", "Intensity"}', 'CrossFit Methodology') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Functional Movement', 'Universal motor recruitment patterns performed core to extremity. Compound, multi-joint, natural, effective, efficient. Can move large loads over long distances quickly.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"CrossFit Prescription", "Core to Extremity", "Intensity", "Mechanics-Consistency-Intensity"}', 'CrossFit Prescription') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Intensity', 'Defined exactly as power: force x distance / time. The independent variable most associated with maximizing favorable adaptation. Distinguish absolute from relative intensity.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D2", "D4"}', '{"CrossFit Prescription", "Functional Movement", "Mechanics-Consistency-Intensity", "Progressive Scaling", "Neuroendocrine Response"}', 'CrossFit Prescription') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Constant Variance', 'The constantly varied element: no ideal routine. Planned variety, not randomness, to expand margins of exposure broadly.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D2"}', '{"CrossFit Prescription", "Hopper Model", "Fringe Athletes", "Three-Day On One-Day Off Template"}', 'CrossFit Prescription') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Neuroendocrine Response', 'Hormonal/neurological changes from exercise. Compound movements elicit increases in testosterone, IGF, HGH. Isolation movements invoke essentially no neuroendocrine response.', 'CFJ_English_Level1_TrainingGuide', '{"D3"}', '{"Functional Movement", "Intensity", "CrossFit Prescription"}', 'CrossFit Methodology') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Work Capacity Across Broad Time and Modal Domains', 'CrossFit''s operational definition of fitness. The fittest individual has the greatest work capacity across all time durations and movement modalities. Fitness = area under the power-time curve.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D2"}', '{"Four Fitness Models", "Hopper Model", "Intensity", "10 General Physical Skills"}', 'Four Fitness Models') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Core to Extremity', 'Sequence of muscle recruitment: from trunk/hips outward to arms/legs. Running, jumping, punching, throwing all originate at the core.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Functional Movement", "Midline Stabilization", "Muted Hip", "Power Zone"}', 'Functional Movement') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Midline Stabilization', 'Maintaining a neutral, braced spine throughout full range of movement under load or speed. Loss reduces power output and increases injury risk.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Core to Extremity", "Power Zone", "Muted Hip", "Air Squat", "Deadlift"}', 'Core to Extremity') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Muted Hip', 'Loss of hip extension at top of movement. Pelvis chases femur instead of staying with spine. Indicates incomplete power transfer.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Core to Extremity", "Midline Stabilization", "Power Zone", "Air Squat", "Deadlift"}', 'Core to Extremity') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Threshold Training', 'Training at the threshold of discomfort — challenging but not breaking mechanics. Coaches manage by manipulating load, speed, complexity.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D2"}', '{"Intensity", "Mechanics-Consistency-Intensity", "Progressive Scaling", "Relative Intensity"}', 'Intensity') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Fringe Athletes', 'Athletes with fitness demands so specialized as to be inconsistent with broad fitness. Sumo wrestlers, marathoners, powerlifters.', 'CFJ_English_Level1_TrainingGuide', '{"D3"}', '{"10 General Physical Skills", "Constant Variance", "Hopper Model"}', 'CrossFit Methodology') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Power Zone', 'Hip extensors and trunk stabilizers: glutes, hamstrings, spinal erectors, quadriceps. Engine of all functional movement.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Core to Extremity", "Midline Stabilization", "Muted Hip", "Deadlift", "Air Squat"}', 'Core to Extremity') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Sport of Fitness', 'CrossFit''s implementation model: whiteboards, clocks, scores, and precise standards. Competition drives intensity that cannot be matched by other means.', 'CFJ_English_Level1_TrainingGuide', '{"D3"}', '{"CrossFit Methodology", "Evidence-Based Fitness", "Intensity"}', 'CrossFit Methodology') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Hopper Model', 'Second fitness model. Every physical challenge on a card in a hopper — fittest person performs well at any random draw. Defines fitness across unknown/unknowable demands.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D2"}', '{"Four Fitness Models", "Constant Variance", "10 General Physical Skills", "Fringe Athletes"}', 'Four Fitness Models') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Bracketing', 'Coaching technique: intentionally overcorrect a fault by cueing the opposite extreme. Athlete self-corrects into the correct range.', 'CFJ_English_Level1_TrainingGuide', '{"D4", "D3"}', '{"Mechanics-Consistency-Intensity", "Virtuosity", "Air Squat"}', 'Coaching Philosophy') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Relative Intensity', 'How hard an effort is relative to an individual''s capacity, vs absolute intensity. Coaches use it to scale so every athlete experiences comparable stimulus.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D2", "D4"}', '{"Intensity", "Progressive Scaling", "Mechanics-Consistency-Intensity", "Threshold Training"}', 'Intensity') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Phosphagen Pathway', 'Energy system for activity under ~10 seconds. Stored ATP and creatine phosphate for immediate high-power output. Requires 2-5 min rest.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D2"}', '{"Glycolytic Pathway", "Oxidative Pathway", "Four Fitness Models"}', 'Four Fitness Models') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Glycolytic Pathway', 'Energy system for ~10 seconds to several minutes. Breaks down glucose without oxygen, producing lactic acid. Fuels most CrossFit WODs.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D2"}', '{"Phosphagen Pathway", "Oxidative Pathway", "Four Fitness Models"}', 'Four Fitness Models') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Oxidative Pathway', 'Energy system for activity longer than several minutes. Uses oxygen for sustained lower-power output. Excessive development costs speed, power, strength.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D2"}', '{"Phosphagen Pathway", "Glycolytic Pathway", "Four Fitness Models", "Fringe Athletes"}', 'Four Fitness Models') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Zone Diet', 'CrossFit''s recommended nutrition: 40% carb, 30% protein, 30% fat in blocks (7g protein, 9g carb, 1.5g fat each). Controls insulin response.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D6"}', '{"World-Class Fitness in 100 Words", "Hyperinsulinism", "Theoretical Hierarchy of Development"}', 'World-Class Fitness in 100 Words') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Hyperinsulinism', 'Chronically elevated insulin from excessive carbohydrate/sugar intake. Root cause of obesity, heart disease, diabetes, hypertension per CrossFit.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D6"}', '{"Zone Diet", "Sickness-Wellness-Fitness Continuum", "World-Class Fitness in 100 Words"}', 'Zone Diet') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Rhabdomyolysis', 'Muscle fibers break down releasing myoglobin into bloodstream, potentially causing kidney damage. Risk: deconditioned athletes, high-volume eccentric loading, novel movements.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D1", "D7"}', '{"Progressive Scaling", "Mechanics-Consistency-Intensity", "Intensity"}', 'Safety') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Progressive Scaling', 'Adjusting load, volume, complexity, or time domain to match capacity while preserving intended stimulus. Not a concession — makes CrossFit universally applicable.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D2", "D4"}', '{"Mechanics-Consistency-Intensity", "Relative Intensity", "Intensity", "Rhabdomyolysis"}', 'Mechanics-Consistency-Intensity') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Tabata Interval', '20 seconds max effort, 10 seconds rest, 8 rounds (4 minutes). Improves both anaerobic and aerobic capacity simultaneously.', 'CFJ_English_Level1_TrainingGuide', '{"D2", "D3"}', '{"Intensity", "Glycolytic Pathway", "Interval Training"}', 'Interval Training') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Task Priority vs Time Priority', 'Two workout structures. Task priority (for time): fixed work, complete AFAP. Time priority (AMRAP): fixed time, max work. Different stimuli.', 'CFJ_English_Level1_TrainingGuide', '{"D2", "D3"}', '{"Intensity", "Constant Variance", "Progressive Scaling"}', 'CrossFit Prescription') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Three-Day On One-Day Off Template', 'Foundational programming template. Three training days, one rest day, cycling continuously. Prevents weekly pattern formation.', 'CFJ_English_Level1_TrainingGuide', '{"D2", "D3"}', '{"Constant Variance", "CrossFit Prescription", "Couplet", "Triplet"}', 'CrossFit Methodology') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Interval Training', 'Alternating high-intensity work with rest. Develops both anaerobic and aerobic capacity simultaneously with greater power output than steady-state.', 'CFJ_English_Level1_TrainingGuide', '{"D2", "D3"}', '{"Tabata Interval", "Intensity", "Glycolytic Pathway", "Oxidative Pathway"}', 'CrossFit Methodology') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Paleolithic Model', 'Humans best adapted to pre-agricultural foods: meat, fish, vegetables, nuts, seeds, fruit. The qualitative framework paired with Zone''s quantitative framework.', 'CFJ_English_Level1_TrainingGuide', '{"D6", "D3"}', '{"World-Class Fitness in 100 Words", "Zone Diet", "Hyperinsulinism"}', 'World-Class Fitness in 100 Words') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- Movements
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Air Squat', 'Foundational body-weight squat. Points of performance: lumbar arch, weight on heels, hip crease below knee, chest high, midsection tight, full hip extension at top.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Front Squat", "Overhead Squat", "Midline Stabilization", "Muted Hip", "Power Zone"}', 'Squat') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Front Squat', 'Loaded squat with bar racked on front of shoulders. Loose fingertip grip, elbows high. Prerequisite to thruster and clean.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Air Squat", "Overhead Squat", "Thruster", "Medicine-Ball Clean"}', 'Squat') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Overhead Squat', 'Ultimate core exercise, heart of the snatch. Load held overhead in frontal plane. Amplifies and punishes faults. Bar must never drift forward.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Air Squat", "Snatch", "Midline Stabilization", "Core to Extremity"}', 'Squat') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Shoulder Press', 'First in press progression. Strict overhead press, no hip drive. Power zone for stabilization only.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Push Press", "Push Jerk", "Midline Stabilization", "Power Zone"}', 'Press Progression') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Push Press', 'Second in press progression. Adds hip-driven dip-and-drive, ~30% more overhead. Power zone provides stability and primary impetus.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Shoulder Press", "Push Jerk", "Core to Extremity", "Muted Hip"}', 'Press Progression') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Push Jerk', 'Third in press progression. Adds second dip (catch in partial OHS). Maximum hip recruitment. ~30% more than push press.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Push Press", "Shoulder Press", "Overhead Squat", "Core to Extremity"}', 'Press Progression') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Deadlift', 'Unrivaled for head-to-toe strength. The safe approach for lifting any object from ground. Prerequisite to snatch and clean. Formerly the healthlift.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Sumo Deadlift High Pull", "Midline Stabilization", "Power Zone", "Clean"}', 'Functional Movement') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Press Progression', 'Teaching sequence: Shoulder Press → Push Press → Push Jerk. Each step increases hip contribution (~30% more weight per step). Teaches core-to-extremity.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Shoulder Press", "Push Press", "Push Jerk", "Core to Extremity", "Muted Hip"}', 'Core to Extremity') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Sumo Deadlift High Pull', 'Wide sumo stance, narrow grip, pull with hips/legs to full extension, shrug, arms pull bar to chin. Great conjugate to thruster. Low-load sub for rowing.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Deadlift", "Thruster", "Core to Extremity", "Muted Hip"}', 'Functional Movement') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Medicine-Ball Clean', 'CrossFit''s teaching tool for the Olympic clean. Dynamax ball 4-30 lb. Reduces to ''pop the hip and drop — catch in a squat.'' Group cleans in 5 minutes.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Clean", "Front Squat", "Deadlift", "Core to Extremity"}', 'Clean') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Thruster', 'Front squat to push press in one fluid motion. Core-to-extremity from below hips to overhead. Pairs with SDHP. Key component of Fran.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Front Squat", "Push Press", "Sumo Deadlift High Pull", "Core to Extremity"}', 'Functional Movement') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Pull-up', 'Fundamental gymnastics movement. Strict (dead hang) or kipping (hip-driven). Kipping is more functional. Strict mastered first.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Muscle-up", "Core to Extremity", "Progressive Scaling", "Rhabdomyolysis"}', 'Functional Movement') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Muscle-up', 'Advanced gymnastics: pull-up + dip in one continuous motion. Demonstrates functional upper-body capacity. Prerequisites: strict pull-ups and ring dips.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Pull-up", "Core to Extremity", "Mechanics-Consistency-Intensity"}', 'Functional Movement') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Snatch', 'World''s fastest lift. Ground to overhead in one motion. Simultaneously demands all 10 physical skills. Heart of the overhead squat.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Overhead Squat", "Deadlift", "Core to Extremity", "Power Zone"}', 'Functional Movement') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term) values ('Clean', 'One of two Olympic lifts. Ground to front rack in one motion. World''s most powerful lift (with jerk). Taught through medicine-ball clean.', 'CFJ_English_Level1_TrainingGuide', '{"D3", "D4"}', '{"Medicine-Ball Clean", "Front Squat", "Deadlift", "Snatch", "Core to Extremity"}', 'Functional Movement') on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- ============================================================
-- d3-anatomy-physiology (CFJ #12, Glassman) — 5 terms
-- ============================================================
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Trunk',
  'The functional unit of the pelvis and spine acting together. CrossFit teaches coaches and athletes to treat the trunk as a single solid segment designed for small range of motion but meant to stay tight and rigid during athletic movement. The trunk transfers force; it does not generate it.',
  'd3-anatomy-physiology',
  '{"D3","D4"}',
  '{"Sacroiliac Joint","Midline Stabilization","Muted Hip","Leg"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Leg',
  'The functional unit of the tibia and femur in CrossFit''s simplified anatomy model. Distinct from the trunk (pelvis + spine). Leg movement is driven by the hip, knee, and ankle joints. Powerful leg function depends on proper hip extension driving force through the leg.',
  'd3-anatomy-physiology',
  '{"D3","D4"}',
  '{"Trunk","Hip Extension","Knee Joint","Muted Hip"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Sacroiliac Joint',
  'The joint connecting the pelvis to the spine — the third joint in CrossFit''s simplified anatomy model (knee, hip, SI joint). Designed for small range of motion in multiple directions. During functional movement, the SI joint and spine remain stable while power is generated through the hip.',
  'd3-anatomy-physiology',
  '{"D3","D4"}',
  '{"Trunk","Hip Joint","Knee Joint","Midline Stabilization","Muted Hip"}',
  'Trunk'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Flexion',
  'Reducing the angle of a joint. CrossFit''s foundational physiology definition. Hip flexion brings trunk toward leg; knee flexion bends the leg; trunk flexion rounds the spine forward. Flexion at the wrong joint during movement is a common coaching fault.',
  'd3-anatomy-physiology',
  '{"D3","D4"}',
  '{"Extension","Hip Joint","Knee Joint","Sacroiliac Joint","Trunk"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Extension',
  'Increasing the angle of a joint. Hip extension — opening the hip to a fully upright position — is the primary driver of elite athletic capacity in CrossFit. Powerful hip extension is "certainly necessary and nearly sufficient for elite athletic capacity" (Glassman). Failure to achieve full hip extension is the defining fault called Muted Hip.',
  'd3-anatomy-physiology',
  '{"D3","D4"}',
  '{"Flexion","Muted Hip","Hip Extension","Power"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- ============================================================
-- d3-scoop-second-pull (CFJ #41, Glassman) — 6 terms
-- ============================================================
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Second Pull',
  'The explosive phase of the Olympic lifts where hips and legs are violently extended once the torso is perpendicular to the ground. Generates the most speed-strength of any athletic movement. Can only be initiated with an upright torso; forward inclination would expose the spine to shear forces. Puts the trajectory of athlete and bar directly upward.',
  'd3-scoop-second-pull',
  '{"D3","D4"}',
  '{"First Pull","Scoop","Speed-Strength","Triple Extension","Hook Grip","Clean","Snatch"}',
  'Clean'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'First Pull',
  'The initial phase of the clean or snatch — functionally a deadlift with shoulders forward of the bar. Bar travels from floor along shins to knee height while torso maintains a constant angle of inclination. Ends as bar passes knees and transitions into the scoop. Kettlebell movements are essentially first pulls with no scoop and no second pull.',
  'd3-scoop-second-pull',
  '{"D3","D4"}',
  '{"Second Pull","Scoop","Deadlift","Clean","Speed-Strength"}',
  'Clean'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Scoop',
  'The transitional movement between first and second pull. As bar passes knees, athlete rotates torso to perpendicular without elevating bar — re-bending the knees (double knee bend). Sets up the second pull: torso upright, hips loaded, bar close. Hip-leg-torso position is identical to the bottom of the dip in the push-press or jerk.',
  'd3-scoop-second-pull',
  '{"D3","D4"}',
  '{"Second Pull","First Pull","Push Press","Push Jerk","Hip Extension","Clean"}',
  'Clean'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Speed-Strength',
  'The combination of starting strength (ability to fire many motor units instantaneously) and explosive strength (ability to keep motor units firing once turned on). Olympic weightlifters have superior speed-strength over all other athletes. Developed through both training AND practice. Only Olympic lifting develops it fully — kettlebells develop endurance but not speed-strength.',
  'd3-scoop-second-pull',
  '{"D3","D4"}',
  '{"Second Pull","Scoop","Power","Clean","Snatch","Triple Extension"}',
  'Power'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Triple Extension',
  'Full simultaneous extension of the hip, knee, and ankle joints at the completion of the second pull. Terminal position of maximal power output in Olympic lifting. Trajectory at triple extension is directly upward. Any failure to reach triple extension represents incomplete power transfer — same fault category as muted hip.',
  'd3-scoop-second-pull',
  '{"D3","D4"}',
  '{"Second Pull","Hip Extension","Extension","Clean","Snatch","Muted Hip"}',
  'Second Pull'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Hook Grip',
  'A barbell grip where the thumb is held tightly against the bar by the fingers (thumb inside, covered by index and middle fingers). Required for Olympic lifts because the second pull is so powerful a standard grip cannot be maintained.',
  'd3-scoop-second-pull',
  '{"D3","D4"}',
  '{"Second Pull","Clean","Snatch","Speed-Strength"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- ============================================================
-- d3-aerobic-paradox (CFJ #52, Kilgore) — 4 terms
-- ============================================================
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'General Adaptation Syndrome',
  'Hans Selye''s 1936 theory: the organism goes through programmed physiological responses to stress. Critical application: homeostatic disruption must occur in a physiological system for adaptation to occur in that same system. Theoretical foundation for why CrossFit''s intensity produces adaptation where conventional aerobic training fails.',
  'd3-aerobic-paradox',
  '{"D2","D3"}',
  '{"Homeostatic Disruption","Long-Slow Distance","Interval Training","Aerobic Paradox"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Homeostatic Disruption',
  'The required stimulus for physiological adaptation. Per General Adaptation Syndrome: disruption must occur in a specific system for adaptation to occur in that system. Long-slow-distance at 70% VO2max does not disrupt oxygen homeostasis in trained individuals — no adaptation results. Only high-intensity intervals (150-250% VO2max) create the disruption needed to drive VO2max gain.',
  'd3-aerobic-paradox',
  '{"D2","D3"}',
  '{"General Adaptation Syndrome","Long-Slow Distance","Interval Training","Intensity","Aerobic Paradox"}',
  'General Adaptation Syndrome'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Long-Slow Distance',
  '60-120 minutes of continuous exercise at ~70% VO2max. Improves oxidative energy substrate storage in trained individuals (athlete can run longer) but does not disrupt oxygen homeostasis and therefore does not improve VO2max (athlete cannot run faster). Only useful for beginners or recovery days in trained athletes.',
  'd3-aerobic-paradox',
  '{"D2","D3"}',
  '{"Interval Training","Homeostatic Disruption","General Adaptation Syndrome","VO2 Max Critique","Aerobic Paradox"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Aerobic Paradox',
  'The phenomenon where CrossFitters dramatically improve aerobic fitness without conventional aerobic training. Explained by homeostatic disruption theory: CrossFit''s high-intensity work disrupts oxygen homeostasis at the muscle, driving VO2max adaptation. The power to improve aerobic fitness lies toward the anaerobic end of the metabolic spectrum.',
  'd3-aerobic-paradox',
  '{"D3"}',
  '{"General Adaptation Syndrome","Homeostatic Disruption","Long-Slow Distance","Interval Training","Intensity"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- ============================================================
-- d3-support-on-rings (CFJ #57, Hass) — 2 terms
-- ============================================================
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Ring Dip',
  'A CrossFit staple movement on gymnastics rings. Standard: hands descend to armpits (below 90 degrees), arms lock out fully at top. Three maturity levels: (1) Immature — rings inward, arms bracing straps; (2) Intermediate — straps clear from body; (3) Mature — rings turned outward throughout, no strap contact.',
  'd3-support-on-rings',
  '{"D3","D4"}',
  '{"Active Shoulders","Muscle-up","Midline Stabilization"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Active Shoulders',
  'The position of actively engaging the shoulder girdle by pushing into the apparatus or ground rather than allowing the shoulders to passively hang. On rings: pushing down so shoulders remain depressed and engaged. In overhead: pressing bar/rings upward with shoulder girdle fully engaged. Passive shoulders in support or overhead positions is a high-priority fault.',
  'd3-support-on-rings',
  '{"D3","D4"}',
  '{"Ring Dip","Handstand","Muscle-up","Overhead Squat","Midline Stabilization"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- ============================================================
-- d3-hip-hollingsworth (Hollingsworth, Nov 2010) — 6 terms
-- ============================================================
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Coxofemoral Joint',
  'The true hip joint — a ball-and-socket articulation between the femoral head and the acetabulum of the pelvis. The power-generation and transfer station that initiates and directs nearly all complex human movements. More stable but less mobile than the shoulder. Supported by a thick ligamentous capsule and the acetabular labrum.',
  'd3-hip-hollingsworth',
  '{"D3","D1"}',
  '{"Trunk","Extension","Muted Hip","Anterior Pelvic Tilt","Gluteus Maximus","Iliopsoas"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Anterior Pelvic Tilt',
  'Forward rotation of the pelvis in the sagittal plane — front tips down, back tips up. Produces hip flexion and increases lumbar lordosis. Caused by tight hip flexors (iliopsoas). Consequences: inhibits gluteus maximus, pre-loads hamstrings (appear tight), limits hip extension. A primary cause of deadlift plateaus.',
  'd3-hip-hollingsworth',
  '{"D3","D4"}',
  '{"Posterior Pelvic Tilt","Iliopsoas","Gluteus Maximus","Lumbo-Pelvic Rhythm","Muted Hip","Midline Stabilization"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Posterior Pelvic Tilt',
  'Backward rotation of the pelvis in the sagittal plane — front tips up, back tips down. Produces hip extension and flattens lumbar lordosis. Opposite of anterior pelvic tilt. In squats, excessive posterior tilt at depth produces butt wink (lumbar flexion under load).',
  'd3-hip-hollingsworth',
  '{"D3","D4"}',
  '{"Anterior Pelvic Tilt","Lumbo-Pelvic Rhythm","Spine Mechanics","Midline Stabilization","Air Squat"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Lumbo-Pelvic Rhythm',
  'The coordinated movement between the hip joint, sacrum, and lumbar spine that allows greater range of motion than any single joint produces in isolation. Example: touching toes with straight knees requires ~90 degrees from the hip plus additional lumbar flexion. Athletes with limited flexibility rely more heavily on this coordination.',
  'd3-hip-hollingsworth',
  '{"D3","D4"}',
  '{"Anterior Pelvic Tilt","Posterior Pelvic Tilt","Sacroiliac Joint","Spine Mechanics","Coxofemoral Joint"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Iliopsoas',
  'The prime hip flexor — composed of the iliacus (from the ilium) and psoas major (from T12-L4 lumbar spine), converging on the proximal femur. If tight: causes anterior pelvic tilt, inhibits gluteus maximus, pre-loads hamstrings, limits hip extension. Tight hip flexors are a primary cause of knee, hip, and lower-back pain.',
  'd3-hip-hollingsworth',
  '{"D3","D4"}',
  '{"Anterior Pelvic Tilt","Gluteus Maximus","Coxofemoral Joint","Muted Hip","Deadlift"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Gluteus Maximus',
  'The primary hip extensor and a key external rotator of the femur. Most active when hip is neutral or fully extended — inhibited by hip flexion. At 35 degrees of hip flexion, hamstrings become the primary hip extensors. Anterior pelvic tilt places hip in chronic flexion, blunting glute potential. Weakness allows knees to roll inward during squats.',
  'd3-hip-hollingsworth',
  '{"D3","D4"}',
  '{"Iliopsoas","Anterior Pelvic Tilt","Extension","Muted Hip","Coxofemoral Joint","Air Squat","Deadlift"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- ============================================================
-- d3-inverted-tucker (Tucker & Hyland, Sept 2011) — 2 terms
-- ============================================================
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Handstand',
  'An inverted gymnastics position balanced on the hands. CrossFit modern standard: body stacked vertically (toes/ankles/knees/hips/shoulders/hands in one line), hollow body bracing, open active shoulders, fingers spread wide. No arch. Rivals the overhead squat in exposing inflexibility and weakness at the shoulder girdle and hip.',
  'd3-inverted-tucker',
  '{"D3","D4"}',
  '{"Hollow Body","Active Shoulders","Midline Stabilization","Overhead Squat"}',
  null
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Hollow Body',
  'A core stabilization position achieved by contracting the core to bring the rib cage toward the hip, shortening the rib cage and flattening the lower back. Subtle sustained bracing, not maximal effort. Creates a rigid vertical line in the handstand. Foundational for all CrossFit gymnastics movements. Loss of hollow = arch in back = position fault.',
  'd3-inverted-tucker',
  '{"D3","D4"}',
  '{"Handstand","Midline Stabilization","Active Shoulders","Ring Dip","Muscle-up"}',
  'Midline Stabilization'
) on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- d3-leverage-kilgore: Getting Some Leverage (Kilgore, CFJ May 2010)
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Mechanical Advantage', 'The ratio of force output to force input in a lever system, determined by the relative lengths of the force arm and resistance arm. A mechanical advantage greater than 1 means less force is required to move a load; less than 1 means force is traded for greater range of motion and velocity. In the human body, most levers operate at a mechanical disadvantage (third-class levers) — muscles must generate force far exceeding the load being moved. Efficient technique maximizes mechanical advantage by keeping the load path close to the body and the center of gravity over the mid-foot.', 'd3-leverage-kilgore', '{"D3"}', '{"First-Class Lever","Second-Class Lever","Third-Class Lever","Moment Arm","Center of Gravity"}', null)
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Moment Arm', 'The perpendicular distance between the axis of rotation (fulcrum) and the line of force application. A lever system has two moment arms: the force arm (distance from fulcrum to where force is applied) and the resistance arm (distance from fulcrum to where resistance/load is applied). The ratio of force arm to resistance arm determines mechanical advantage. Moment = force × moment arm length. Longer force arm relative to resistance arm means less force needed to overcome resistance.', 'd3-leverage-kilgore', '{"D3"}', '{"Mechanical Advantage","First-Class Lever","Second-Class Lever","Third-Class Lever"}', 'Mechanical Advantage')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('First-Class Lever', 'A lever arrangement where the axis (fulcrum) is between the force and resistance — F-A-R. The most versatile lever class: can balance forces, change direction of force, amplify force, and modify speed and range of motion depending on the relative lengths of the force and resistance arms. Example in the human body: nodding the head (neck extensors apply force at the rear of the skull, the atlas is the fulcrum, and the face is the resistance). A teeter-totter is the classic non-biological example.', 'd3-leverage-kilgore', '{"D3"}', '{"Second-Class Lever","Third-Class Lever","Moment Arm","Mechanical Advantage"}', 'Mechanical Advantage')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Second-Class Lever', 'A lever arrangement where the resistance is between the axis and force — F-R-A. The force arm is always longer than the resistance arm, so mechanical advantage is always greater than 1 — this arrangement always favors force production. Rare in the human body according to Gray''s Anatomy. Classic example: a wheelbarrow. In CrossFit biomechanics, the push-up is sometimes cited as an approximation. Because the force arm is always dominant, second-class levers require less muscular force to move a load than other lever classes.', 'd3-leverage-kilgore', '{"D3"}', '{"First-Class Lever","Third-Class Lever","Moment Arm","Mechanical Advantage"}', 'Mechanical Advantage')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Third-Class Lever', 'A lever arrangement where the force is between the axis and resistance — R-F-A. The resistance arm is always longer than the force arm, so mechanical advantage is always less than 1 — this arrangement always favors range of motion and velocity at the cost of requiring larger muscular force. The most common lever class in the human body. Classic example: the biceps curl (elbow is axis, biceps inserts on radius as force, hand/load is resistance). Muscles must generate forces many times the load being lifted.', 'd3-leverage-kilgore', '{"D3"}', '{"First-Class Lever","Second-Class Lever","Moment Arm","Mechanical Advantage"}', 'Mechanical Advantage')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Center of Gravity', 'The point within a body or system at which the total mass can be considered to be concentrated — equal distribution of mass in all directions from that point. In a normal standing human, the center of gravity is approximately above and slightly behind the navel. For stable movement, the center of gravity must remain over the base of support (mid-foot in most lifts). Poor technique — such as a forward-leaning torso in the deadlift or squat — shifts the center of gravity forward, creating unnecessary lever arms and increasing injury risk. Coaching efficient technique means keeping the load path as close to vertical and as close to the body as possible, keeping the system''s center of gravity over mid-foot.', 'd3-leverage-kilgore', '{"D3"}', '{"Mechanical Advantage","Moment Arm","Air Squat","Deadlift"}', null)
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- CCFT Brain — D4 Training seed data
-- Generated: 2026-04-06

-- d4-where-barbells: Where Barbells Come From (Mitchell & Rippetoe, CFJ Issue 60, Aug 2007)
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Olympic Barbell', 'A barbell designed to IWF (International Weightlifting Federation) specifications for use in dynamic barbell movements (clean, jerk, snatch). Men''s bar: 20 kg, 28 mm shaft diameter. Women''s bar: 15 kg, 25 mm shaft diameter. Thinner diameter allows faster rotation and easier hook grip. The bar is intentionally flexible ("whippy") — bar whip assists the athlete in the transition phases of Olympic lifts. Sleeves spin freely on bushings or needle bearings to allow the bar to rotate during the catch, reducing torque on the wrists. Contrasted with powerlifting bars, which are thicker, stiffer, and designed to minimize oscillation.', 'd4-where-barbells', '{"D4"}', '{"Bar Whip","Hook Grip","Tensile Strength","Yield Strength"}', null)
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Bar Whip', 'The flex or oscillation of a barbell under dynamic loading — the stored elastic energy in the bar that assists the athlete during the transition phases of Olympic lifts. A "whippy" bar bends when loaded and releases that energy at the right moment in the pull, helping drive the bar upward during the clean, jerk, or snatch. Desirable in Olympic weightlifting bars; NOT desirable in powerlifting bars (squat, bench, deadlift), where bar oscillation at heavy loads disrupts stability and control. Bar whip is a product of thinner shaft diameter, higher steel grade, and bar length.', 'd4-where-barbells', '{"D4"}', '{"Olympic Barbell","Hook Grip","Second Pull","Triple Extension"}', 'Olympic Barbell')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Tensile Strength', 'The amount of stress (measured in psi — pounds per square inch) a material can withstand before breaking. For barbells, tensile strength describes the bar''s resistance to catastrophic failure under load. A bar with high tensile strength is very hard to break. However, tensile strength alone is insufficient for evaluating bar quality — a bar can have high tensile strength but still develop a permanent bend over time if its yield strength is inadequate. Tensile strength answers: will it snap?', 'd4-where-barbells', '{"D4"}', '{"Yield Strength","Olympic Barbell"}', null)
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Yield Strength', 'The amount of stress (in psi) a material can sustain without permanent distortion. Below the yield threshold, a bar deforms elastically — it bends under load and returns perfectly straight when unloaded. Above the yield threshold, plastic deformation occurs: the bar takes on a permanent bend. Yield strength is the more important metric for training bar longevity. A bar can have high tensile strength (won''t break) but low yield strength (will eventually bow from repeated heavy squats and deadlifts). The closer tensile and yield strength are to each other, the better the bar.', 'd4-where-barbells', '{"D4"}', '{"Tensile Strength","Olympic Barbell"}', null)
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- d4-movement101-kilgore: Movement 101 (Kilgore, CFJ 2009)
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Anatomical Position', 'The universal reference position for describing human anatomy and movement: lying flat on the back, palms facing up. An artificial construct — not how humans naturally stand — but a shared baseline that allows coaches, trainers, and clinicians to communicate precisely about body part locations and movement directions. Think of it as the body''s version of "true north." All directional terms (anterior/posterior, proximal/distal, etc.) are defined relative to this reference, not to how the body is currently positioned during an exercise.', 'd4-movement101-kilgore', '{"D4"}', '{"Anterior","Posterior","Proximal","Distal","Medial","Lateral","Anatomical Planes"}', null)
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Anatomical Planes', 'The three cardinal imaginary planes that divide the body, all intersecting at the body''s center of gravity. Sagittal Plane: divides body into left and right halves (front-to-back); flexion and extension occur here. Frontal Plane: divides body into front and back halves (side-to-side); abduction and adduction occur here. Transverse Plane: divides body into top and bottom (horizontal at the waist); rotation occurs here. Every plane has a corresponding axis of rotation. Planes are academic tools for detecting movement faults; coaches translate to plain language for athletes.', 'd4-movement101-kilgore', '{"D4"}', '{"Anatomical Position","Flexion","Extension","Abduction","Adduction","Rotation"}', 'Anatomical Position')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Anterior', 'A directional term meaning "in front of" another structure, relative to anatomical position. The toes are anterior to the heels. The quad is anterior to the femur. In CrossFit context, anterior pelvic tilt describes the hips tipping forward; anterior knee pain is pain at the front of the knee. Opposite: posterior (behind).', 'd4-movement101-kilgore', '{"D4"}', '{"Posterior","Anatomical Position","Anterior Pelvic Tilt"}', 'Anatomical Position')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Posterior', 'A directional term meaning "behind" another structure, relative to anatomical position. The erector spinae are posterior to the abdominal cavity. In CrossFit, "posterior chain" refers to the muscles along the back of the body — glutes, hamstrings, and erectors — which drive hip extension. Posterior pelvic tilt = tailbone tucks under, flattening the lumbar curve. Opposite: anterior (in front).', 'd4-movement101-kilgore', '{"D4"}', '{"Anterior","Anatomical Position","Posterior Pelvic Tilt","Gluteus Maximus"}', 'Anatomical Position')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Proximal', 'A directional term meaning closer to the center of the body (or to the origin of a limb) than another structure. The knee is proximal to the foot. The elbow is proximal to the wrist. Proximal stability enables distal mobility — stable hips and core allow powerful, controlled foot and hand positioning. Opposite: distal (farther from center).', 'd4-movement101-kilgore', '{"D4"}', '{"Distal","Anatomical Position"}', 'Anatomical Position')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Distal', 'A directional term meaning farther from the center of the body (or from the origin of a limb) than another structure. The hand is distal to the elbow. The foot is distal to the knee. Distal segments (hands, feet) are where force is ultimately applied to barbells, pull-up bars, or the floor. Coaching application: a wrist fault in the front rack often traces back to a proximal elbow or shoulder restriction. Opposite: proximal (closer to center).', 'd4-movement101-kilgore', '{"D4"}', '{"Proximal","Anatomical Position"}', 'Anatomical Position')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Medial', 'A directional term meaning closer to the midline (center) of the body than another structure. The sternum is medial to both shoulders. The spine is medial to the ribs. "Medial knee collapse" describes the knee caving inward — a common squat fault caused by weak glutes. The coaching cue "knees out" corrects medial knee drift. Opposite: lateral (away from midline).', 'd4-movement101-kilgore', '{"D4"}', '{"Lateral","Anatomical Position","Gluteus Maximus","Air Squat"}', 'Anatomical Position')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Lateral', 'A directional term meaning farther from the midline (center) of the body than another structure. The shoulders are lateral to the sternum. The outer knee is lateral to the inner knee. "Spread the floor" in a squat creates lateral force through the feet, activating the glutes and preventing medial knee collapse. Opposite: medial (toward midline).', 'd4-movement101-kilgore', '{"D4"}', '{"Medial","Anatomical Position"}', 'Anatomical Position')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Abduction', 'Movement of a body segment away from the midline of the body, occurring in the frontal plane. Memory anchor: to abduct is to take away. Raising the arm out to the side = shoulder abduction. Pushing knees out in a squat = hip abduction. The glutes are the primary hip abductors — weakness causes medial knee collapse. Coaches say "knees out" but the anatomical action is femoral abduction. Opposite: adduction (toward midline).', 'd4-movement101-kilgore', '{"D4"}', '{"Adduction","Anatomical Planes","Medial","Lateral","Gluteus Maximus","Air Squat"}', 'Anatomical Planes')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Adduction', 'Movement of a body segment toward the midline of the body, occurring in the frontal plane. Bringing the arm back to the side = shoulder adduction. Knees caving inward in a squat = uncontrolled hip adduction — a critical fault. The adductor group (inner thigh) drives hip adduction. Memory: ADDuction = ADD to the middle. Opposite: abduction (away from midline).', 'd4-movement101-kilgore', '{"D4"}', '{"Abduction","Anatomical Planes","Medial","Air Squat"}', 'Anatomical Planes')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Pronation', 'Rotation of the forearm so the palm faces downward — palms down orientation. The radius rotates over the ulna. In the gym: overhand (pronated) grip = knuckles up. Used in deadlift, barbell row, most pulling movements. Also describes foot mechanics: foot pronation = arch collapse inward during gait. Opposite: supination (palm up).', 'd4-movement101-kilgore', '{"D4"}', '{"Supination","Hook Grip","Anatomical Position"}', null)
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Supination', 'Rotation of the forearm so the palm faces upward — palms up orientation. The ulna stays fixed while the radius rotates back. In the gym: underhand (supinated) grip = knuckles down. Used in chin-ups, and required for the clean rack position. Anatomical position itself is supinated. Memory: supination = "hold the soup bowl." Opposite: pronation (palm down).', 'd4-movement101-kilgore', '{"D4"}', '{"Pronation","Hook Grip","Anatomical Position"}', null)
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Dorsiflexion', 'Movement at the ankle joint in which the toes and ball of the foot are pulled upward, decreasing the angle between the top of the foot and the shin. Required for squat depth — the ankle must dorsiflex to allow the shin to travel forward over the foot. Restricted dorsiflexion (tight calves) causes heel rise in the squat, shifts center of gravity forward, and forces compensatory torso lean. Opposite: plantarflexion (toes down).', 'd4-movement101-kilgore', '{"D4"}', '{"Plantarflexion","Air Squat","Anatomical Position"}', null)
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Plantarflexion', 'Movement at the ankle joint in which the toes and ball of the foot are pushed downward, increasing the angle between the top of the foot and the shin — the toes-pointed position. Action of the calf muscles (gastrocnemius and soleus). Occurs at peak triple extension in the clean and snatch. Tight calves create chronic plantarflexion and directly limit dorsiflexion range. Opposite: dorsiflexion (toes up).', 'd4-movement101-kilgore', '{"D4"}', '{"Dorsiflexion","Triple Extension","Anatomical Position"}', null)
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Superior', 'A directional term meaning higher than another structure (relative to anatomical position). The head is superior to the pelvis. The shoulder is superior to the hip. Describes vertical location only — not movement. Opposite: inferior (lower).', 'd4-movement101-kilgore', '{"D4"}', '{"Inferior","Anatomical Position"}', 'Anatomical Position')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Inferior', 'A directional term meaning lower than another structure (relative to anatomical position). The chin is inferior to the nose. The pelvis is inferior to the ribcage. Describes vertical location only — not movement. Used clinically: "inferior angle of the scapula" is the bottom tip of the shoulder blade. Opposite: superior (higher).', 'd4-movement101-kilgore', '{"D4"}', '{"Superior","Anatomical Position"}', 'Anatomical Position')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- d4-bench-starr: The Role of the Bench Press in Strength Training (Starr, CFJ Feb 2012)
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Rotator Cuff', 'A group of four muscles (supraspinatus, infraspinatus, teres minor, subscapularis — SITS) whose tendons surround and stabilize the glenohumeral (shoulder) joint. Controls rotation and holds the head of the humerus securely in the shallow shoulder socket during overhead and pressing movements. Small, delicate muscles — vulnerable when overloaded or chronically undertrained. The rise of rotator cuff injuries in strength training correlates with the 1970s shift from overhead pressing to flat bench pressing: heavy overhead work strengthens the rotator cuff, while exclusive bench pressing without overhead work leaves it vulnerable.', 'd4-bench-starr', '{"D4"}', '{"Active Shoulders","Handstand","Bench Press"}', null)
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Bench Press', 'A horizontal pressing movement performed lying on a bench: bar lowered under control to the lower chest/end of the sternum, brief pause, driven to full lockout. Described as the most dangerous exercise in strength training because the bar travels directly over the face and chest — failure without a spotter can be catastrophic. Key form standards: secure grip with thumbs around bar; forearms vertical, wrists over elbows; wrists straight; feet flat on floor as foundation; shoulder blades and glutes locked into bench; bar to end of breastbone without bouncing; hold breath throughout for intrathoracic pressure. Faults: bridging, bouncing, false grip, excessive arch. Overuse without complementary overhead work creates rotator cuff vulnerability.', 'd4-bench-starr', '{"D4"}', '{"Rotator Cuff","False Grip","Shoulder Press"}', null)
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('False Grip', 'A bar grip where the thumb is NOT wrapped around the bar — it rests alongside the fingers rather than around the bar. Also called thumbless grip or suicide grip. In bench pressing: dangerous — bar can slip from hands with no recovery, directly onto face or chest. Never acceptable on the bench press. Separate meaning in gymnastics: on rings, "false grip" is a legitimate technique where the wrist presses into the ring to shorten the pull path in the muscle-up transition — this usage is correct and intentional.', 'd4-bench-starr', '{"D3","D4"}', '{"Bench Press","Hook Grip","Ring Dip"}', null)
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- d4-cbt-hermiz: Building Mental Toughness (Hermiz, CFJ January 2012)
-- Note: Mental Toughness term already exists from d1-mental-game (Shrago); updating domains only via upsert
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Mental Toughness', 'The ability to continue according to plan in a way that is in line with your values even though negative thoughts and emotions are pulling you in another direction (Hermiz). The fastest, strongest athlete can be undone by a weak mind. Mental toughness is trainable, not innate. CrossFit develops it mechanically: high-intensity work pushes athletes into the anaerobic zone where affective responses go negative and lactic acid byproducts trigger pain receptors, generating thoughts of quitting. Consistently overcoming these moments builds a cognitive rule: "a situation might seem hopeless, but if I keep going I''ll get through it." Coach''s role: scale for success, progressively challenge, hold athletes to their plans, and teach thought observation (cognitive defusion). Every quit weakens mental toughness; every completion strengthens it.', 'd4-cbt-hermiz', '{"D1","D4","D5"}', '{"Goal Setting","Cognitive Defusion","General Adaptation Syndrome"}', 'Goal Setting')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('Cognitive Defusion', 'A technique from Acceptance and Commitment Therapy (ACT) — the third wave of cognitive behavioral therapy — in which a person learns to separate themselves from their thoughts and feelings. The goal is not to eliminate negative thoughts but to observe them from a distance: having a thought rather than being the thought. In training: when an athlete thinks "I can''t finish this" mid-WOD, cognitive defusion means recognizing that thought as a normal byproduct of high-intensity exertion — not a command to quit. ACT paradox: "If you''re not willing to have it, you''ve got it." Trying to suppress unwanted feelings intensifies them. CrossFit''s repeated exposure to discomfort builds tolerance rather than avoidance.', 'd4-cbt-hermiz', '{"D4"}', '{"Mental Toughness","General Adaptation Syndrome"}', 'Mental Toughness')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- d4-rowing-row2k: Strategies for a Seven Minute 2K on the Concept II Rower (CFJ November 2002)
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values ('2K Row', 'A prominent benchmark in athlete development: 2000 meters on the Concept II Rowing Ergometer. The 7-minute 2K (2K/7) is the standard of a "better rower" in CrossFit. Pace is measured in 500m splits — the time to row each 500-meter segment. A 7-minute 2K requires a consistent 1:45 per 500m split. Multiple training approaches converge on the goal: distance priority (set for 2K, reduce time), time priority (set for 7 min, increase distance), pace priority (hold 1:45/500m), and interval approaches (break into intervals with progressive rest reduction). Each approach operates at different intensity and time domains, providing metabolically distinct cross-training for a single goal. Principle generalizes: multiple converging approaches to any benchmark are superior to any single approach alone.', 'd4-rowing-row2k', '{"D4"}', '{"Benchmark Workouts","Long-Slow Distance","Aerobic Paradox"}', 'Benchmark Workouts')
on conflict (term) do update set definition=excluded.definition, source=excluded.source, domains=excluded.domains, related_terms=excluded.related_terms, parent_term=excluded.parent_term;

-- CCFT Brain — D5 Leadership & Management
-- Seed file for vocab_terms table
-- Run in Supabase SQL Editor after schema migration (20260406000002)

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Aging and Performance',
  'Kilgore''s analysis of how aging affects physical capacity. Physical capacity inevitably declines with age, but fitness has dramatic effects on health and quality of life. Active aging dramatically outperforms sedentary aging — 80-year-old athletes are stronger than non-athletes in their prime at 25. The rate and degree of decline is significantly modifiable through training. CrossFit''s definition of health as "fitness across age" directly applies.',
  'CFJ_2015_11_Aging_Kilgore2',
  '{"D1","D5"}',
  '{"Masters Quadrant","Sickness-Wellness-Fitness Continuum","Progressive Scaling","D1 — Screening and Ongoing Assessment"}',
  'Masters Quadrant'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Completion Window',
  'A forecasted time range (for task-priority workouts) or total round/rep count (for time-priority workouts) that the coach establishes before class to guide scaling decisions. Armed with a completion window, the coach can quickly determine if an athlete''s scaled version will produce the intended stimulus. If scaled athletes finish drastically faster or slower than the window, it signals a scaling error.',
  'CFJ_2015_10_Scaling_Gordon_4',
  '{"D2","D5"}',
  '{"Scaling Strategies","Task Priority vs Time Priority","Relative Intensity"}',
  'Scaling Strategies'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'CrossFit Kids',
  'CrossFit''s program for individuals ages 3–18, providing foundational movement patterns, a portion of prescribed physical activity, and lifestyle/nutrition education in a fun, engaging format. The program is infinitely scalable and adapted to developmental stages: preschool (3–5) uses games and storytelling cues; kids (6–12) focus on points of performance with game as the primary motivator; teens (13–18) use more structured formats with positive feedback as critical to engagement. Key principles include physical literacy, countering Exercise Deficit Disorder, fun-first learning, elaborate encoding, and repetition with variety. No maximal loading for prepubescent athletes — movement quality over intensity at all ages.',
  'TG_Online_Kids',
  '{"D5","D2"}',
  '{"Progressive Scaling","Mechanics-Consistency-Intensity","Masters Quadrant","D5 — Leadership and Management","Sickness-Wellness-Fitness Continuum"}',
  'D5 — Leadership and Management'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Deeper Side of Coaching',
  'Ben Bergeron''s framework distinguishing good coaches from great coaches. Good coaches see faults and correct them — necessary but not sufficient. Great coaches go beyond movements through three deeper competencies: Awareness (reading what athletes think and feel; treating each athlete the way they want to be treated), Trust (built by listening deeply and sincerely, not by demonstrating knowledge; never gossip about members), and Positive Coaching (framing cues in the positive because the subconscious mind ignores the word "don''t"). These competencies build the relational foundation required for lasting athlete development.',
  'CFJ_Coaching_Bergeron',
  '{"D3","D4","D5"}',
  '{"Virtuosity","Mechanics-Consistency-Intensity","Bracketing","D4 — Training","D5 — Leadership and Management"}',
  'Coaching Philosophy'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Goal Setting',
  'Amundson''s framework for coaching the mental side of CrossFit. Goals must be specific, measurable, and time-bound. Coaches should help athletes set both process goals (improve mechanics) and outcome goals (hit a PR). Positive self-talk and mental preparation are trainable skills, not innate traits. Applies across D1 (initial goal identification during screening) and D5 (ongoing athlete development and motivation).',
  'CFJ_Amundson_Goals',
  '{"D1","D5"}',
  '{"D1 — Screening and Ongoing Assessment","D5 — Leadership and Management","Deeper Side of Coaching","Pursuit of Excellence"}',
  'D5 — Leadership and Management'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Masters Quadrant',
  'A framework for categorizing and coaching aging athletes using four variables — Goals (Performance vs. Wellness), Age (Early Masters 40–54 vs. Late Masters 55+), Fitness Level (Fit vs. Deconditioned), and Injury State (Uninjured vs. Injured) — creating 16 archetypes with specific coaching priorities. Resolving injury takes highest priority over all else. Late masters tolerate reduced volume and load (~70% of Rx''d, extra rest day per week) and tend to underestimate their ability, while early masters tend to overestimate. Wellness athletes need broad GPP stimulus, not competition-style training. CrossFit defines health as fitness across age — the goal is to increase work capacity throughout life, not merely maintain it.',
  'sme_masters_trainingguide',
  '{"D5","D1","D2"}',
  '{"Progressive Scaling","Relative Intensity","Sickness-Wellness-Fitness Continuum","D5 — Leadership and Management","D1 — Screening and Ongoing Assessment","Rhabdomyolysis"}',
  'D5 — Leadership and Management'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Mental Toughness',
  'The ability to continue according to plan in a way that is in line with your values even though negative thoughts and emotions are pulling you in another direction (Hermiz). CrossFit develops mental toughness mechanically: high-intensity work pushes athletes into the anaerobic zone where affective responses go negative, lactic acid byproducts trigger pain receptors, and the mind generates thoughts of quitting — consistently overcoming these moments builds a cognitive rule that transfers outside the gym. The coach''s role is to scale properly so beginners succeed, progressively challenge athletes, hold athletes to their plan, and teach cognitive defusion (observing negative thoughts without acting on them). Mental toughness is trainable, not innate.',
  'CFJ_Shrago_MentalGame',
  '{"D1","D4","D5"}',
  '{"Goal Setting","Cognitive Defusion","General Adaptation Syndrome","Deeper Side of Coaching"}',
  'Goal Setting'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Positive Coaching',
  'CrossFit''s coaching principle that cues must be framed in the positive rather than the negative. The subconscious mind cannot process a negation — it focuses on the action and ignores the word "don''t," so "don''t slow down" registers as "slow down." Correct cues state what the coach wants the athlete to do: "stay strong," "push the pace," "chest up," "push knees out." This applies to all coaching cues, not just motivational language, and is a core component of Bergeron''s Deeper Side of Coaching framework.',
  'CFJ_Coaching_Bergeron',
  '{"D4","D5"}',
  '{"Deeper Side of Coaching","Bracketing","D4 — Training"}',
  'Deeper Side of Coaching'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Pursuit of Excellence',
  'Bergeron''s philosophy for affiliate ownership, grounded in Glassman''s maxim: "The blind and relentless pursuit of excellence is what determines success." Excellence means pouring all resources into improving the lives of current members — not marketing, competition software, or new revenue streams. The governing question is "Them not me": what can I do today to improve my members'' experience and their lives overall? Priorities (golf balls) are community relationships, member health and results, coach development, and personal connection. Distractions (sand) are software choices, marketing campaigns, and competitor pricing.',
  'CFJ_Excellence_Bergeron_FINAL2',
  '{"D5","D4"}',
  '{"Deeper Side of Coaching","D5 — Leadership and Management","Virtuosity"}',
  'D5 — Leadership and Management'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Six Abilities of Effective Training',
  'The L2 Training Guide''s framework defining six areas of capacity that determine a trainer''s effectiveness; deficiency in any one area inhibits overall success. The six abilities are: (1) Teaching — possessing knowledge and the ability to impart it by adapting communication style to the student; (2) Seeing — visual recognition of faults in static and dynamic positions, best viewed from a 45-degree offset; (3) Correcting — using short, specific, actionable cues, triaging faults, balancing critique with praise, and staying to assess whether the cue worked; (4) Group Management — minimizing logistical time to maximize teaching time while ensuring each athlete feels individually coached; (5) Presence and Attitude — recognizing each person''s unique abilities and goals, and genuinely caring about their success; (6) Demonstration — using one''s own movement as a teaching tool and leading by example in standards and values.',
  'CFJ_English_L2_TrainingGuide',
  '{"D4","D3","D5"}',
  '{"Mechanics-Consistency-Intensity","Virtuosity","Deeper Side of Coaching","Positive Coaching","Static and Dynamic Faults","Triage","D4 — Training"}',
  'D4 — Training'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

-- CCFT Brain — D6 Lifestyle Education
-- Seed file for vocab_terms table
-- Run in Supabase SQL Editor after schema migration (20260406000002)

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Cancer and Exercise',
  'CrossFit''s position that physical activity reduces cancer risk and that CrossFit-style training can be appropriate for cancer survivors with medical clearance. Exercise provides measurable benefits across the Sickness-Wellness-Fitness Continuum even for those managing chronic disease. Coaches must work within scope of practice: medical clearance is required, modifications applied as needed, and fatigue or tolerance monitored closely.',
  'CFJ_2016_06_Cancer-Saline4',
  '{"D6","D1"}',
  '{"Sickness-Wellness-Fitness Continuum","CCFT Scope of Practice","Progressive Scaling"}',
  'Sickness-Wellness-Fitness Continuum'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Dairy and Nutrition Science',
  'Kilgore''s evidence-based examination of dairy''s role in nutrition, separating fact from marketing fiction. CrossFit''s dietary framework (Paleo + Zone) generally limits dairy because it was not part of the pre-agricultural diet, but the science is nuanced. Coaches should evaluate dairy claims against measurable outcomes rather than dogmatically excluding or including it — the core principle is evidence-based nutrition, not tradition.',
  'CFJ_Kilgore_MilkingFact',
  '{"D6"}',
  '{"Paleolithic Model","Zone Diet","Evidence-Based Fitness"}',
  'Paleolithic Model'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Fueling for Performance',
  'Wunderle''s framework for timing nutrition around training — covering pre-workout, intra-workout, and post-workout fueling strategies for CrossFit athletes. While CrossFit''s primary nutritional prescription (Paleo + Zone) governs overall diet quality and quantity, fueling addresses specifically when to eat relative to training. Provides practical guidance for coaches helping athletes optimize recovery and performance through meal timing, and stays within scope of practice (general guidance, not medical nutrition therapy).',
  'CFJ_Wunderle_Fueling',
  '{"D6"}',
  '{"Zone Diet","Paleolithic Model","Macronutrient Prescription"}',
  null
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Hyperinsulinism',
  'Chronically elevated insulin levels caused by excessive carbohydrate intake, particularly refined carbohydrates and sugar. CrossFit identifies hyperinsulinism as a root cause of many chronic diseases including obesity, coronary heart disease, diabetes, and hypertension. The Zone Diet combats hyperinsulinism by controlling carbohydrate intake and balancing macronutrient ratios, positioning insulin management as the primary metabolic mechanism underlying the sickness end of the Sickness-Wellness-Fitness Continuum.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D6"}',
  '{"Zone Diet","Sickness-Wellness-Fitness Continuum","World-Class Fitness in 100 Words"}',
  'Zone Diet'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Intermittent Fasting',
  'An eating pattern involving occasional extended fasting periods, explored in the CrossFit context by Dr. John Berardi across multiple IF protocols. IF is compatible with both Zone and Paleo approaches because it addresses when to eat, not what to eat. CrossFit presents IF as one dietary strategy among several — not a universal prescription — and coaches may educate athletes about it but cannot prescribe it as a diet, which crosses into dietetics scope of practice.',
  'CFJ_If_Berardi',
  '{"D6"}',
  '{"Zone Diet","Paleolithic Model","World-Class Fitness in 100 Words"}',
  null
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Macronutrient Prescription',
  'Synkowski''s practical framework for nutrition coaching in CrossFit, building on the Zone Diet''s 40C/30P/30F macro ratios with implementation guidance. Covers how to assess an athlete''s current nutrition, set block prescriptions based on lean body mass and activity level, and adjust over time based on results. Emphasizes that CrossFit''s nutrition approach combines quality (Paleo/whole foods) with quantity (Zone blocks) for maximum effect.',
  'CFJ_2016_11_Nutrition3-Synkwoski4',
  '{"D6"}',
  '{"Zone Diet","Paleolithic Model","Micronutrients and Food Quality","World-Class Fitness in 100 Words"}',
  'Zone Diet'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Micronutrients and Food Quality',
  'CrossFit''s framework for evaluating food quality beyond macronutrient ratios. The closer a food is to its natural form, the higher its concentration of micronutrients (13 vitamins, 14 minerals) and phytonutrients; industrial processing strips these elements and adds dyes, chemicals, and empty calories. Glucose (from vegetables and grains) and fructose (from fruit and table sugar) are metabolized differently — fresh fruit and table sugar are approximately 50/50 fructose/glucose, which is why CrossFit limits fruit intake ("some fruit") while eliminating refined sugar entirely.',
  'CFJ_2016_10_Nutrition2-Synkowski3',
  '{"D6"}',
  '{"Zone Diet","Paleolithic Model","Hyperinsulinism","World-Class Fitness in 100 Words"}',
  'World-Class Fitness in 100 Words'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Paleolithic Model',
  'The nutritional principle that humans are best adapted to eat foods available to pre-agricultural ancestors: meat, fish, vegetables, nuts, seeds, and fruit. CrossFit adopts the paleolithic model as a qualitative dietary framework — describing what to eat (avoiding processed foods, grains, sugar, and excess starch) — while the Zone Diet provides the quantitative framework for how much to eat. Together they form CrossFit''s full nutritional prescription: real food in measured amounts, supporting exercise without promoting body fat.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D6","D3"}',
  '{"World-Class Fitness in 100 Words","Zone Diet","Hyperinsulinism","Sickness-Wellness-Fitness Continuum"}',
  'World-Class Fitness in 100 Words'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Sickness-Wellness-Fitness Continuum',
  'CrossFit''s fourth fitness model, which holds that health markers (blood pressure, cholesterol, heart rate, body fat, muscle mass, flexibility, strength) exist on a continuum from sickness (pathological) through wellness (normal) to fitness (better than normal). Elite athletes typically show these parameters in the exceptional range. CrossFit''s view is that fitness and health are the same thing — fitness provides a hedge against chronic disease, and a trainer always achieves superior health outcomes compared to the "side effects" of drugs and surgery.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D6"}',
  '{"Four Fitness Models","10 General Physical Skills","World-Class Fitness in 100 Words","CrossFit Prescription"}',
  'Four Fitness Models'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Sleep and Recovery',
  'CrossFit recognizes sleep as a critical performance and health variable. Insufficient sleep impairs recovery, reduces training capacity, and undermines the benefits of exercise. Retrospective bias causes athletes to underestimate how much poor sleep affects them, leading to chronically insufficient rest. Coaches should educate athletes that prioritizing more sleep can directly translate to PRs and improved health markers — sleep is explicitly listed alongside nutrition as a lifestyle factor in the CCFT Content Outline.',
  'CFJ_Sleep_Beers_FINAL4',
  '{"D6"}',
  '{"Sickness-Wellness-Fitness Continuum"}',
  null
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Sugar and Sports Drinks',
  'CrossFit''s position that sports beverages contain substantial added sugar that undermines health and performance. Many athletes assume sports drinks are essential, but CrossFit''s "no sugar" prescription applies to them as much as to sodas. Athletes who switch from sports drinks to water typically see improved body composition and performance without negative effects — the default recommendation for most training is water, not sugar-containing beverages.',
  'CFJ_2015_07_Sugar_Beers6',
  '{"D6"}',
  '{"World-Class Fitness in 100 Words","Hyperinsulinism","Zone Diet"}',
  'World-Class Fitness in 100 Words'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'World-Class Fitness in 100 Words',
  'Glassman''s canonical summary of CrossFit''s prescription for total fitness. It prescribes eating meat and vegetables, nuts and seeds, some fruit, little starch, and no sugar — keeping intake to levels that support exercise but not body fat. It directs athletes to practice and train major lifts, master gymnastics basics, and regularly perform hard metabolic conditioning across multiple modalities. This passage unifies nutrition, training, and lifestyle into a single directive and is the most-quoted text in CrossFit education; the "no sugar" and "intake levels that support exercise but not body fat" elements are frequently tested.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D6"}',
  '{"CrossFit Prescription","Zone Diet","10 General Physical Skills","Sickness-Wellness-Fitness Continuum","Constant Variance"}',
  'CrossFit Methodology'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Zone Diet',
  'CrossFit''s recommended nutritional framework, developed by Dr. Barry Sears. The Zone Diet prescribes precise macronutrient ratios of 40% carbohydrate, 30% protein, and 30% fat, measured in "blocks" — a block being 7g protein, 9g carbohydrate, or 1.5g fat. Daily block totals are calculated from an individual''s lean body mass and activity level. CrossFit recommends the Zone as a starting point because its balanced macronutrient intake controls insulin response and provides measurable, adjustable precision.',
  'CFJ_English_Level1_TrainingGuide',
  '{"D3","D6"}',
  '{"World-Class Fitness in 100 Words","Hyperinsulinism","Theoretical Hierarchy of Development","Sickness-Wellness-Fitness Continuum"}',
  'World-Class Fitness in 100 Words'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

-- CCFT Brain — D7 Professional Responsibilities
-- Seed file for vocab_terms table
-- Run in Supabase SQL Editor after schema migration

-- d7-211: Injuries among Weightlifters and Powerlifters (Aasa et al., Br J Sports Med 2017)
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Barbell Sport Injury Epidemiology',
  'Systematic review of 9 studies (Aasa et al., 2017) examining injuries in Olympic weightlifting and powerlifting. Weightlifting injury incidence: 2.4–3.3 injuries per 1,000 hours of training. Powerlifting: 1.0–4.4 injuries per 1,000 hours of training. Most common injury locations in both sports: low back/spine, shoulder, and knee. Injury types: muscle and tendon injuries dominate; ~59–60% acute, ~25–40% chronic/overuse. Compared to other sports: injury incidence is similar to non-contact strength/power sports (track and field: 3.57/1000hr; alpine skiing: 1.7/1000hr) and LOW compared to contact sports (American football: 9.6/1000hr; wrestling: 5.7/1000hr). In weightlifting, 90.5% of injuries forced less than 1 day of absence. Coaching implication: monitor low back, shoulder, and knee complaints; proper technique reduces risk in these specific areas.',
  'd7-211',
  '{"D7"}',
  '{"Rotator Cuff","Bench Press","Deadlift","Air Squat","Scope of Practice"}',
  null
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;


-- d7-exercise-kills: Safety: For Athletes and Trainers (Kilgore, CFJ 2009)
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Informed Consent',
  'Pre-participation document — distinct from and following PAR-Q screening — in which the trainer discloses: (1) what exercise services will be provided, (2) what the client will experience, (3) what benefits will result, and (4) what risks are associated with participation, explicitly including the possibility that exercise can kill. Must be written and signed by both trainee and trainer. Usually combined with an assumption-of-risk and waiver-of-liability statement, in which the trainee acknowledges being fully informed of benefits and risks, willingly assumes all risks for any injuries, and releases the trainer and facility from liability. Legal sequence: PAR-Q screening → Informed Consent + Waiver → begin training. Failure to obtain informed consent is an open door for negligence litigation.',
  'd7-exercise-kills',
  '{"D7"}',
  '{"PAR-Q","Scope of Practice","Professional Liability Insurance","Liability Waiver"}',
  'Scope of Practice'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Professional Liability Insurance',
  'Absolute necessity for exercise professionals (Kilgore). Even when all screening, informed consent, and safety standards are met, someone will eventually be injured — statistics guarantee it. Professional liability insurance protects against unwarranted negligence or malpractice claims, but only provides protection if (1) screening was done, (2) informed consent and waiver were obtained, and (3) the coach can defend in court the exercises used, conditions, rationale, physiological effects, and appropriateness for that specific client. The expert standard: if opposing counsel appears more knowledgeable about exercise anatomy, the jury will question the coach''s competence. Kilgore''s 3 Rules: Safety First (screen), Don''t Go to Jail (informed consent/waiver), No Guarantees (carry insurance).',
  'd7-exercise-kills',
  '{"D7"}',
  '{"Informed Consent","PAR-Q","Scope of Practice"}',
  'Scope of Practice'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;


-- d7-infections: Skin Infections and the CrossFit Athlete (Ray, CFJ December 2010)
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Cellulitis',
  'Bacterial skin infection — the most common infectious risk in CrossFit training (Ray, 2010). Occurs when bacteria enter through a break in the skin (torn hand, scraped shin, blister) and multiply, causing inflammation and damage. Most common bacteria: streptococcus species and Staphylococcus aureus (staph). MRSA (methicillin-resistant staph aureus) is an antibiotic-resistant strain requiring specific antibiotics (Bactrim, doxycycline, clindamycin, or IV vancomycin for severe cases). Tetanus (Clostridium tetani) is an additional risk; update immunization every 10 years, within 5 years for significant wounds. Necrotizing fasciitis is a rare but life- and limb-threatening progression. Warning signs: spreading redness, increasing pain, streaking from wound, pus. Prevention: soap-and-water wound wash (most important step), bandage wounds, clean equipment with bleach or iodine for blood. Coaching implication: direct athletes with open wounds to clean and bandage before continuing; MRSA, HIV, and hepatitis are transmissible via blood on shared equipment.',
  'd7-infections',
  '{"D7"}',
  '{"Scope of Practice","Informed Consent","PAR-Q"}',
  'Scope of Practice'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

-- d7-waiver: Protecting Your Business: The Waiver (Ames, CFJ March 2010)
insert into vocab_terms (term, definition, source, domains, related_terms, parent_term)
values (
  'Liability Waiver',
  'Pre-participation legal document every athlete must sign before training — no exceptions including friends, family, free training, or children (Ames, 2010). Without one, a coach is "one bad day away from bankruptcy." Four required sections: (1) Basic information — name, DOB, address, phone, email, emergency contact; (2) Health questions — smoking, alcohol, medications (what they treat, not drug names — some cause dizziness/fainting under exercise), exercise history, injuries/surgeries, chronic conditions (hypertension, asthma, diabetes, heart condition), catch-all for other conditions; (3) Photography/video release — consent for marketing use of images; (4) Waiver and release of liability — assumption of risk (trainee accepts injury/death risks), release (releases facility and coaches from liability including negligence), and indemnification (trainee covers attorney fees; accepts financial responsibility for injury caused to others). Signatures: participant signs; minors require parent/guardian signature; reviewing coach also signs certifying full review. Limitations: even a good waiver can be thrown out in court — it cannot stand alone without screening, informed consent, insurance, and scope-of-practice training.',
  'd7-waiver',
  '{"D7"}',
  '{"Informed Consent","PAR-Q","Professional Liability Insurance","Scope of Practice"}',
  'Scope of Practice'
)
on conflict (term) do update set
  definition = excluded.definition,
  source = excluded.source,
  domains = excluded.domains,
  related_terms = excluded.related_terms,
  parent_term = excluded.parent_term;

