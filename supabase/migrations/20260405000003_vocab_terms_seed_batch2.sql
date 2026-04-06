-- =============================================
-- CCFT Vocab Brain — Batch 2
-- Extracted from: D3 (9 docs), D4 (6 docs), D6 (8 docs)
-- =============================================

insert into public.vocab_terms (term, definition, source, domains) values

-- =============================================
-- D3 — CFJ_Coaching_Bergeron
-- =============================================
('Awareness', 'The ability to read, understand, and recognize what athletes are thinking, feeling, and capable of to adjust coaching accordingly.', 'CFJ_Coaching_Bergeron', array['D3']),
('Trust', 'Foundation of the athlete-coach relationship built through listening deeply and leading by example with integrity.', 'CFJ_Coaching_Bergeron', array['D3']),
('Coaching the Positive', 'Using positive language in coaching cues because the subconscious mind cannot process negatives and focuses only on the action.', 'CFJ_Coaching_Bergeron', array['D3']),
('Self-Fulfilling Prophecy', 'When a coach''s words are replayed in an athlete''s mind and create a belief system that guides performance outcomes.', 'CFJ_Coaching_Bergeron', array['D3']),

-- =============================================
-- D3 — 12_03_Anatomy_Physiology
-- =============================================
('Trunk', 'The pelvis and spine as a functional unit in movement.', '12_03_Anatomy_Physiology', array['D3']),
('Hip Joint', 'The articulation between the femur and pelvis that is the primary source of dynamic power generation in athletic movements.', '12_03_Anatomy_Physiology', array['D3']),
('Knee Joint', 'The articulation connecting the tibia and femur, critical to leg extension and flexion.', '12_03_Anatomy_Physiology', array['D3']),
('Sacroiliac Joint', 'The connection between the pelvis and spine that must remain stable during lifting and functional movements.', '12_03_Anatomy_Physiology', array['D3']),
('Muted Hip Function', 'When the pelvis chases the femur instead of staying connected to the spine, preventing powerful hip extension.', '12_03_Anatomy_Physiology', array['D3', 'D4']),
('Frozen Hip', 'A condition where the pelvis chases the femur and the hip angle remains open, resulting in powerless hip extension.', '12_03_Anatomy_Physiology', array['D3', 'D4']),
('Trunk Neutral', 'A stable spinal position with normal curvature where the spine and pelvis maintain their relationship.', '12_03_Anatomy_Physiology', array['D3', 'D4']),

-- =============================================
-- D3 — 41_06_Scoop_Second_Pull (Olympic lifting)
-- =============================================
('Speed Strength', 'A combination of starting strength and explosive strength enabling rapid athletic movement.', '41_06_Scoop_Second_Pull', array['D3', 'D4']),
('First Pull', 'The initial deadlift-like phase of the clean where the bar travels along the shin with constant torso angle.', '41_06_Scoop_Second_Pull', array['D3', 'D4']),
('Scoop', 'The re-bending of the knees as the bar passes knee level and the athlete rotates the torso to perpendicular without elevating the bar.', '41_06_Scoop_Second_Pull', array['D3', 'D4']),
('Double Knee Bend', 'Another term for the scoop phase where knees re-bend to prepare for violent hip-leg extension.', '41_06_Scoop_Second_Pull', array['D3', 'D4']),
('Second Pull', 'The violent extension of hips and legs that occurs when the torso is perpendicular, generating upward trajectory.', '41_06_Scoop_Second_Pull', array['D3', 'D4']),
('Hook Grip', 'A grip where the thumb is held tightly against the bar by the fingers, necessary to maintain grip during powerful second pull.', '41_06_Scoop_Second_Pull', array['D3', 'D4']),

-- =============================================
-- D3 — 52_06_Aerobic_Paradox
-- =============================================
('General Adaptation Syndrome', 'The body''s programmed physiological response to stress that drives adaptation and fitness improvement.', '52_06_Aerobic_Paradox', array['D2', 'D3', 'D4']),
('Homeostatic Disruption', 'A disruption of homeostasis in a physiological system that is necessary for adaptation and fitness improvement.', '52_06_Aerobic_Paradox', array['D2', 'D4']),
('VO2max', 'The maximum amount of oxygen the body can consume at maximal effort; the absolute marker of aerobic fitness.', '52_06_Aerobic_Paradox', array['D1', 'D2']),
('Long-Slow-Distance Training', 'Energy substrate-depleting aerobic training done for 60-120 minutes at approximately 70% of VO2max.', '52_06_Aerobic_Paradox', array['D2']),
('Interval Training', 'Shorter and more intense segments of effort with short rest periods to improve lactate kinetics and VO2max.', '52_06_Aerobic_Paradox', array['D2']),

-- =============================================
-- D3 — 63_07_Spine_Mechanics
-- =============================================
('Compression (spinal)', 'A force pressing spinal tissues together perpendicular to the surface; primary force in axial loading.', '63_07_Spine_Mechanics', array['D3', 'D4']),
('Reaction Shear', 'Shear force resulting from gravity pulling the load and upper body downward during a lift.', '63_07_Spine_Mechanics', array['D3', 'D4']),
('Joint Shear', 'The resultant shear force at a vertebral joint produced by the sum of reaction shear and muscle/ligament forces.', '63_07_Spine_Mechanics', array['D3', 'D4']),
('Lumbar Lordosis', 'Natural curvature of the lower spine that must be maintained during lifting to prevent excessive shear and injury.', '63_07_Spine_Mechanics', array['D3', 'D4']),
('Neutral Spine', 'A spinal posture that maintains natural curves and minimizes shear forces during dynamic movements.', '63_07_Spine_Mechanics', array['D3', 'D4']),
('Lumbar Flexion', 'Rounding forward of the lower back that increases ligament loading and joint shear on the spine.', '63_07_Spine_Mechanics', array['D3', 'D4']),

-- =============================================
-- D3 — CFJ_Hollingsworth_Hip
-- =============================================
('Coxofemoral Joint', 'The true hip joint formed between the head of the femur and the acetabulum of the pelvis.', 'CFJ_Hollingsworth_Hip', array['D3']),
('Acetabulum', 'The cup-like socket on the pelvis that receives the head of the femur to form the hip joint.', 'CFJ_Hollingsworth_Hip', array['D3']),
('Acetabular Labrum', 'A wedge-shaped ring of cartilage encircling the acetabulum that increases depth and improves hip stability.', 'CFJ_Hollingsworth_Hip', array['D3']),
('Lumbo-Pelvic Rhythm', 'Coordinated movement between the hip joint, sacrum, and lumbar spine that allows greater range of motion than any single joint alone.', 'CFJ_Hollingsworth_Hip', array['D3', 'D4']),
('Iliopsoas', 'The primary hip flexor muscle composed of the iliacus and psoas major that can create hip-flexor-dominant movement patterns.', 'CFJ_Hollingsworth_Hip', array['D3']),
('Rectus Femoris', 'The only two-joint muscle of the quadriceps group that crosses both the hip and knee, influencing motion at each.', 'CFJ_Hollingsworth_Hip', array['D3']),
('Gluteus Maximus', 'The powerful hip extensor responsible for violent hip opening required in explosive athletic movements.', 'CFJ_Hollingsworth_Hip', array['D3', 'D4']),
('Hamstrings', 'Two-joint muscles that aid hip extension and knee flexion; become primary hip extensors when hip is flexed beyond 35 degrees.', 'CFJ_Hollingsworth_Hip', array['D3', 'D4']),
('Gluteus Medius', 'A prime mover for hip abduction and stabilizer of the pelvis during single-leg stance activities.', 'CFJ_Hollingsworth_Hip', array['D3']),
('Piriformis', 'A deep hip external rotator positioned near the sciatic nerve whose tightness can cause compression and pain.', 'CFJ_Hollingsworth_Hip', array['D3']),
('Anterior Pelvic Tilt', 'Forward tilting of the pelvis that produces hip flexion and increases lumbar lordosis.', 'CFJ_Hollingsworth_Hip', array['D3', 'D4']),
('Posterior Pelvic Tilt', 'Backward tilting of the pelvis that produces hip extension and flattens lumbar lordosis.', 'CFJ_Hollingsworth_Hip', array['D3', 'D4']),
('Hip-Flexor Tightness', 'Shortened or tight hip flexors that cause anterior pelvic tilt and lengthen the hamstrings, limiting hip extension.', 'CFJ_Hollingsworth_Hip', array['D3', 'D4']),

-- =============================================
-- D3 — CFJ_Kilgore_Leverage
-- =============================================
('Lever', 'A simple machine consisting of a rigid frame (bone), fulcrum (joint), force (muscle), and resistance (load).', 'CFJ_Kilgore_Leverage', array['D3', 'D4']),
('Fulcrum', 'The axis of rotation around which a lever operates; in the body, represented by joints.', 'CFJ_Kilgore_Leverage', array['D3', 'D4']),
('Force Arm', 'The distance from the point of force application to the fulcrum; affects mechanical advantage of a lever system.', 'CFJ_Kilgore_Leverage', array['D3', 'D4']),
('Resistance Arm', 'The distance from the point of resistance application to the fulcrum; affects the difficulty of moving a load.', 'CFJ_Kilgore_Leverage', array['D3', 'D4']),
('Mechanical Advantage', 'The relative advantage gained by a lever system; longer force arms provide greater advantage.', 'CFJ_Kilgore_Leverage', array['D3', 'D4']),
('First-Class Lever', 'A lever with the fulcrum between force and resistance (F-A-R); can balance forces and change direction.', 'CFJ_Kilgore_Leverage', array['D3', 'D4']),
('Second-Class Lever', 'A lever with resistance between force and fulcrum; the force arm is always longer than the resistance arm.', 'CFJ_Kilgore_Leverage', array['D3', 'D4']),
('Third-Class Lever', 'A lever with force between resistance and fulcrum; the most common type in the human body, emphasizing range and velocity.', 'CFJ_Kilgore_Leverage', array['D3', 'D4']),
('Center of Gravity', 'The point within the body where there is equal mass above, below, in front, and behind; changes with body position.', 'CFJ_Kilgore_Leverage', array['D3', 'D4']),
('Moment (torque)', 'The product of force and the perpendicular distance from the axis of rotation; determines rotational effect.', 'CFJ_Kilgore_Leverage', array['D3', 'D4']),

-- =============================================
-- D3 — 57_07_Support_on_Rings
-- =============================================
('Support Position', 'A static hold on rings or parallel bars with arms locked and body suspended, foundational to gymnastic strength.', '57_07_Support_on_Rings', array['D3', 'D4']),
('Ring Dip', 'A gymnastics movement performed on rings significantly more difficult than bar dips due to unstable equipment.', '57_07_Support_on_Rings', array['D3', 'D4']),
('Immature Ring Dip', 'Early progression where rings are held tight to the body and turned inward, with arms pushing against the straps.', '57_07_Support_on_Rings', array['D3', 'D4']),
('Mature Ring Dip', 'Advanced progression where rings remain turned outward with palms forward, keeping forearms from contacting straps.', '57_07_Support_on_Rings', array['D3', 'D4']),

-- =============================================
-- D3 — CFJ_Inverted_Tucker_Sept2011
-- =============================================
('Handstand', 'An inverted static hold on the hands that develops balance, strength, spatial awareness, and core control.', 'CFJ_Inverted_Tucker_Sept2011', array['D3', 'D4']),
('Hollow Body Position', 'A core bracing technique where the rib cage is brought toward the hips for stability in inverted positions.', 'CFJ_Inverted_Tucker_Sept2011', array['D3', 'D4']),
('Modern Handstand', 'Contemporary inverted position with neutral head, straight body line, and proper hollow bracing for efficiency.', 'CFJ_Inverted_Tucker_Sept2011', array['D3', 'D4']),
('Body Tension', 'Muscular contraction and engagement throughout the body to maintain structural integrity during inverted movements.', 'CFJ_Inverted_Tucker_Sept2011', array['D3', 'D4']),

-- =============================================
-- D4 — CFJ_Excellence_Bergeron_FINAL2
-- =============================================
('Golf Balls Principle', 'Core business priorities: community, member relationships, member health/happiness, and coach integrity — fill the jar with these first.', 'CFJ_Excellence_Bergeron_FINAL2', array['D4', 'D5']),
('Pebbles Principle', 'Secondary business priorities: programming, coaching staff education, movement correction ability, and class effectiveness.', 'CFJ_Excellence_Bergeron_FINAL2', array['D4', 'D5']),
('Sand Principle', 'Trivial business distractions — marketing, competitor focus, pricing — that consume resources without advancing member outcomes.', 'CFJ_Excellence_Bergeron_FINAL2', array['D4', 'D5']),

-- =============================================
-- D4 — CFJ_Kilgore_Movement101
-- =============================================
('Anatomical Position', 'Reference posture with the body flat on the back, palms facing up; universal standard for describing body locations.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Anterior', 'A structure located in front of another structure relative to anatomical position.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Posterior', 'A structure located behind another structure relative to anatomical position.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Proximal', 'A structure closer to the center of the body or beginning of an extremity than another structure.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Distal', 'A structure farther from the center of the body or beginning of an extremity than another structure.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Superior', 'A structure that is higher than another structure relative to anatomical position.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Inferior', 'A structure that is lower than another structure relative to anatomical position.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Medial', 'A structure closer to the cardinal sagittal plane (center) than another structure.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Lateral', 'A structure farther away from the cardinal sagittal plane than another structure.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Sagittal Plane', 'An anatomical plane that divides the body into right and left sides, passing from front to back.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Frontal Plane', 'An anatomical plane that divides the body into front and back halves, passing side to side.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Transverse Plane', 'An anatomical plane that divides the body into top and bottom at the waist, perpendicular to the long axis.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Circumduction', 'A movement where the joint acts as a pivot point and the distal segment moves in a circle around the joint.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Supination', 'Rotation of the hand to a palms-up orientation at the elbow and wrist joints.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Pronation', 'Rotation of the hand to a palms-down orientation at the elbow and wrist joints.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Dorsiflexion', 'Movement at the ankle joint lifting the toes and ball of the foot upward.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Plantarflexion', 'Movement at the ankle joint pushing the toes and ball of the foot downward.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Eversion', 'Rolling the ankle with the sole of the foot facing outward.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Inversion', 'Rolling the ankle with the sole of the foot facing toward the midline.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Protraction', 'Movement of the shoulders forward (scapular abduction).', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),
('Retraction', 'Movement of the shoulders backward (scapular adduction); opposite of protraction.', 'CFJ_Kilgore_Movement101', array['D3', 'D4']),

-- =============================================
-- D4 — CFJ_CBT_Hermiz
-- =============================================
('Mental Toughness', 'The ability to continue according to plan in a way aligned with your values even though negative thoughts and emotions pull you in another direction.', 'CFJ_CBT_Hermiz', array['D4', 'D5']),
('Cognitive Defusion', 'A mental technique where individuals separate themselves from their thoughts and feelings, observing thoughts without becoming them.', 'CFJ_CBT_Hermiz', array['D4', 'D5']),
('Acceptance and Commitment Therapy (ACT)', 'A therapy form that treats negative thoughts and emotions as normal and natural, emphasizing tolerance rather than elimination.', 'CFJ_CBT_Hermiz', array['D4', 'D5']),
('Committed Action', 'Taking deliberate, planned action aligned with personal values regardless of negative thoughts or emotions present.', 'CFJ_CBT_Hermiz', array['D4', 'D5']),
('Quitting Rule', 'Principle that quitting a planned workout (unless injury risk exists) diminishes mental toughness and increases future quitting behavior.', 'CFJ_CBT_Hermiz', array['D4']),

-- =============================================
-- D4 — CFJ_Bench_Starr
-- =============================================
('False Grip', 'Dangerous grip where thumbs are not wrapped around the bar, increasing risk of the bar slipping from hands.', 'CFJ_Bench_Starr', array['D4']),
('Sticking Point', 'The most difficult portion of a pressing movement where the lifter must overcome maximum resistance and apply peak force.', 'CFJ_Bench_Starr', array['D4']),
('Intrathoracic Pressure', 'Positive pressure maintained by holding breath during heavy pressing, creating a rock-solid foundation.', 'CFJ_Bench_Starr', array['D4']),
('Spotter Role', 'Trained assistant who helps lifter take the bar from uprights, returns it safely, and aids only if lifter becomes trapped.', 'CFJ_Bench_Starr', array['D4', 'D5']),

-- =============================================
-- D4 — 60_07_Where_Barbells
-- =============================================
('Yield Strength', 'The amount of stress (in psi) a barbell material can withstand without permanent distortion or bending.', '60_07_Where_Barbells', array['D4']),
('Tensile Strength', 'The amount of stress (in psi) a barbell material can withstand before breaking or complete failure.', '60_07_Where_Barbells', array['D4']),
('Whip', 'Desired bar flexibility in Olympic lifting that facilitates the rebound effect during cleans, jerks, and snatches.', '60_07_Where_Barbells', array['D4']),
('Knurl', 'The rough, checkered surface pressed into the barbell shaft that provides grip friction for hands, shoulders, and back.', '60_07_Where_Barbells', array['D4']),
('Needle Bearing', 'Precision bearing system allowing barbell sleeves to rotate freely; more expensive but longer-lasting than bushings.', '60_07_Where_Barbells', array['D4']),

-- =============================================
-- D4 — Row2K_Nov02
-- =============================================
('Distance Priority', 'Training approach where focus is on increasing distance covered in a set time period.', 'Row2K_Nov02', array['D2', 'D4']),
('Pace Priority', 'Training approach where focus is on maintaining a specific pace across varying distances or durations.', 'Row2K_Nov02', array['D2', 'D4']),
('Work-to-Rest Ratio', 'The timing relationship between exercise intervals and recovery periods; progressively reduced to build capacity.', 'Row2K_Nov02', array['D2', 'D4']),
('Convergent Paths', 'Multiple distinct training approaches that progress toward the same fitness goal through different metabolic routes.', 'Row2K_Nov02', array['D2', 'D4']),
('Incremental Progression', 'Systematic advancement through training by gradually increasing intensity, volume, or reducing rest periods.', 'Row2K_Nov02', array['D2', 'D4']),

-- =============================================
-- D6 — CFJ_2015_07_Sugar_Beers6
-- =============================================
('Insulin Spike', 'Rapid elevation of insulin levels in the blood caused by sugar consumption, affecting blood glucose regulation.', 'CFJ_2015_07_Sugar_Beers6', array['D6']),
('Blood Sugar Levels', 'The concentration of glucose in the bloodstream, measured in mg/dL; normal fasting range is 80-120 mg/dL.', 'CFJ_2015_07_Sugar_Beers6', array['D6']),
('Added Sugar', 'Sugar consumed beyond what is naturally present in food, contributing to metabolic dysfunction and health risks.', 'CFJ_2015_07_Sugar_Beers6', array['D6']),
('Glycogen', 'The stored form of glucose in muscles and liver, providing energy for high-intensity performance lasting 1.5-2 hours.', 'CFJ_2015_07_Sugar_Beers6', array['D1', 'D6']),

-- =============================================
-- D6 — CFJ_2016_06_Cancer-Saline4
-- =============================================
('Warburg Effect', 'The metabolic process where damaged cells resort to aerobic glycolysis, consuming glucose to fuel unbridled growth.', 'CFJ_2016_06_Cancer-Saline4', array['D6']),
('Ketogenic Diet', 'A low-carbohydrate, high-fat diet that increases ketone bodies in the blood, starving cancer cells of glucose.', 'CFJ_2016_06_Cancer-Saline4', array['D6']),
('Ketone Bodies', 'Alternative fuel molecules created when the body breaks down fat due to low insulin and carbohydrate levels.', 'CFJ_2016_06_Cancer-Saline4', array['D6']),
('Ketosis', 'Metabolic state achieved at approximately 50 grams of carbohydrate intake per day, shifting energy from glucose to fat.', 'CFJ_2016_06_Cancer-Saline4', array['D6']),
('Systemic Inflammation', 'Chronic low-level inflammation throughout the body, linked to increased cancer risk and metabolic dysfunction.', 'CFJ_2016_06_Cancer-Saline4', array['D6']),

-- =============================================
-- D6 — CFJ_2016_10_Nutrition2-Synkowski3
-- =============================================
('Micronutrients', 'Vitamins and minerals required in small amounts; critical for ATP production, oxygen delivery, and antioxidant capacity.', 'CFJ_2016_10_Nutrition2-Synkowski3', array['D6']),
('Phytonutrients', 'Plant-based compounds like resveratrol and curcumin with antioxidant and anti-inflammatory effects.', 'CFJ_2016_10_Nutrition2-Synkowski3', array['D6']),
('Empty Calories', 'Calories from processed food lacking micronutrients and phytonutrients, representing a lost opportunity for health.', 'CFJ_2016_10_Nutrition2-Synkowski3', array['D6']),
('Muscle Glycogen', 'Carbohydrate stored directly in muscle tissue, critical for refilling energy stores after high-intensity exercise.', 'CFJ_2016_10_Nutrition2-Synkowski3', array['D1', 'D6']),
('Fiber', 'Non-digestible carbohydrate that slows digestion, blunts insulin spikes, and promotes satiety without caloric impact.', 'CFJ_2016_10_Nutrition2-Synkowski3', array['D6']),

-- =============================================
-- D6 — CFJ_2016_11_Nutrition3-Synkwoski4
-- =============================================
('Basal Metabolic Rate', 'Calories burned at rest maintaining basic physiology like heart rate and body temperature.', 'CFJ_2016_11_Nutrition3-Synkwoski4', array['D6']),
('Thermic Effect of Feeding', 'Energy expended during digestion and nutrient absorption, approximately 10% of total caloric intake.', 'CFJ_2016_11_Nutrition3-Synkwoski4', array['D6']),
('Macronutrient Split', 'The percentage of daily calories from carbohydrates, protein, and fat; affects performance and body composition.', 'CFJ_2016_11_Nutrition3-Synkwoski4', array['D6']),
('Caloric Deficit', 'Consuming fewer calories than expended; necessary for fat loss but can compromise performance if too aggressive.', 'CFJ_2016_11_Nutrition3-Synkwoski4', array['D6']),

-- =============================================
-- D6 — CFJ_If_Berardi (Intermittent Fasting)
-- =============================================
('Intermittent Fasting', 'Extended periods without eating (12-24+ hours), alternated with eating windows; provides metabolic and cellular benefits.', 'CFJ_If_Berardi', array['D6']),
('Autophagy', 'Cellular turnover and repair process enhanced during extended fasting, removing damaged cellular components.', 'CFJ_If_Berardi', array['D6']),
('Fatty Acid Oxidation', 'The metabolic process of breaking down fat for energy, increased during extended fasting periods.', 'CFJ_If_Berardi', array['D6']),
('Insulin Sensitivity', 'The body''s ability to regulate blood glucose effectively; improved through intermittent fasting and carbohydrate restriction.', 'CFJ_If_Berardi', array['D6']),
('Oxidative Stress', 'Cellular damage from reactive oxygen species; reduced through intermittent fasting and improved metabolic health.', 'CFJ_If_Berardi', array['D6']),

-- =============================================
-- D6 — CFJ_Kilgore_MilkingFact
-- =============================================
('Lactose Intolerance', 'Reduced ability to produce lactase enzyme for breaking down milk sugar; manageable with modest dairy portions.', 'CFJ_Kilgore_MilkingFact', array['D6']),
('Milk Allergy', 'Rare immune response to milk proteins (0.4% of population); different from lactose intolerance and potentially dangerous.', 'CFJ_Kilgore_MilkingFact', array['D6']),
('Recovery Drink', 'Beverage combining carbohydrate and protein (3:1 or 4:1 ratio) to replenish glycogen and support muscle repair.', 'CFJ_Kilgore_MilkingFact', array['D6']),

-- =============================================
-- D6 — CFJ_Sleep_Beers_FINAL4
-- =============================================
('Growth Hormone', 'Hormone released during sleep supporting bone and muscle recovery; 50-60% released at night during first half of sleep.', 'CFJ_Sleep_Beers_FINAL4', array['D6']),
('Cortisol', 'Stress hormone detrimental in chronic elevations; impairs energy utilization, increases fat storage, and breaks down muscle.', 'CFJ_Sleep_Beers_FINAL4', array['D6']),
('Sleep Quality', 'Duration and consistency of sleep affecting hormonal regulation; 8-10 hours nightly optimal for athletic recovery.', 'CFJ_Sleep_Beers_FINAL4', array['D6']),

-- =============================================
-- D6 — CFJ_Wunderle_Fueling
-- =============================================
('Glycogen Depletion', 'Complete exhaustion of stored muscle carbohydrate, occurring after approximately 1.5-2 hours of high-intensity effort.', 'CFJ_Wunderle_Fueling', array['D1', 'D6']),
('In-Competition Fueling', 'Nutrition strategy during endurance events lasting 2+ hours, replacing 300-600 calories per hour based on intensity.', 'CFJ_Wunderle_Fueling', array['D6']),
('Caloric Burn Rate', 'Individual energy expenditure during exercise, varying 400-750 calories per hour depending on effort and body composition.', 'CFJ_Wunderle_Fueling', array['D6']),
('Hypernatremia', 'Elevated blood sodium from dehydration or excessive electrolyte intake; less common than hyponatremia.', 'CFJ_Wunderle_Fueling', array['D6']),
('Sweat Rate', 'Individual fluid loss per hour of exercise, determined by weighing before and after activity; varies with temperature and intensity.', 'CFJ_Wunderle_Fueling', array['D6']),
('Sodium Replacement', 'Electrolyte management consuming 150-250 mg sodium per 8 oz. water to maintain muscle function and nerve transmission.', 'CFJ_Wunderle_Fueling', array['D6']),
('Pre-Competition Nutrition', 'Carbohydrate loading strategy increasing intake before multi-WOD days to maximize glycogen stores.', 'CFJ_Wunderle_Fueling', array['D6']),
('Post-Workout Recovery', 'Optimal refueling with 3:1 carbohydrate-to-protein ratio within recovery window to replenish glycogen and repair muscle.', 'CFJ_Wunderle_Fueling', array['D6'])

on conflict (term) do nothing;
