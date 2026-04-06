export interface StudyDocument {
  id: string
  title: string
  description: string
  domain: string
  priority: 'critical' | 'high' | 'medium'
  url: string
  focusAreas: string[]
}

// Replace url values with your OneDrive share links
export const DOCUMENTS: StudyDocument[] = [
  {
    id: 'l1-guide',
    title: 'L1 Training Guide',
    description: 'CrossFit Level 1 Training Guide — foundational coaching framework covering all 7 domains.',
    domain: 'D3',
    priority: 'critical',
    url: 'ONEDRIVE_LINK_PLACEHOLDER',
    focusAreas: ['10 general physical skills', '4 fitness models', 'Mechanics → Consistency → Intensity', 'Nutrition basics', 'Coaching standards'],
  },
  {
    id: 'l2-guide',
    title: 'L2 Training Guide',
    description: 'CrossFit Level 2 Training Guide — advanced coaching, seeing/correcting, 6 areas of effective training.',
    domain: 'D4',
    priority: 'critical',
    url: 'ONEDRIVE_LINK_PLACEHOLDER',
    focusAreas: ['9 foundational movement sheets', '6 areas of effective training', 'Static vs dynamic faults', 'Threshold training', 'Midline stabilization'],
  },
  {
    id: 'masters-guide',
    title: 'Masters Training Guide',
    description: 'Special populations coaching for older athletes — self-awareness matrix, repetition budgets.',
    domain: 'D5',
    priority: 'critical',
    url: 'ONEDRIVE_LINK_PLACEHOLDER',
    focusAreas: ['Early vs late masters', 'Self-awareness belief matrix', 'Repetition budget', 'Movement substitution', 'SpO2 monitoring'],
  },
  {
    id: 'kids-guide',
    title: 'Kids Training Guide',
    description: 'CrossFit Kids programming — age groups, learning styles, behavior management.',
    domain: 'D5',
    priority: 'critical',
    url: 'ONEDRIVE_LINK_PLACEHOLDER',
    focusAreas: ['Age groups (5-12, 12-18)', 'Learning modalities', 'Neuromotor development', 'Behavior management', 'Nutrition for youth'],
  },
  {
    id: 'scaling',
    title: 'Scaling CrossFit Workouts (Gordon)',
    description: 'The definitive scaling framework — 4 scaling elements, experience levels, completion windows.',
    domain: 'D2',
    priority: 'critical',
    url: 'ONEDRIVE_LINK_PLACEHOLDER',
    focusAreas: ['4 scaling elements', '6 general movement patterns', 'Experience levels', 'Completion window', 'Pre-scaled workouts'],
  },
  {
    id: 'virtuosity',
    title: 'Virtuosity (Glassman)',
    description: 'Performing the common uncommonly well — the foundational philosophy of CrossFit coaching.',
    domain: 'D3',
    priority: 'critical',
    url: 'ONEDRIVE_LINK_PLACEHOLDER',
    focusAreas: ['Virtuosity defined', 'Novice\'s curse', 'Gymnastics elements (Risk, Originality, Virtuosity)', 'Couplets/triplets', 'Programming philosophy'],
  },
  {
    id: 'volume',
    title: 'A Deft Dose of Volume (Hobart)',
    description: 'Programming volume, variance, and intensity — when more is not more.',
    domain: 'D2',
    priority: 'high',
    url: 'ONEDRIVE_LINK_PLACEHOLDER',
    focusAreas: ['Volume defined', 'Variance principle', 'Singlets/couplets/triplets', 'Chipper workouts', 'Intensity hierarchy'],
  },
  {
    id: 'anatomy',
    title: 'Anatomy & Physiology Primer (Kilgore)',
    description: 'Full skeletal, muscular, cardiac, and renal anatomy for coaching application.',
    domain: 'D1',
    priority: 'high',
    url: 'ONEDRIVE_LINK_PLACEHOLDER',
    focusAreas: ['Skeletal system', 'Muscular system (actin/myosin)', 'Cardiac anatomy', 'Respiratory system', 'Renal system'],
  },
  {
    id: 'energy-systems',
    title: 'Energy System Development (ijspt)',
    description: 'Load management, return to play, StARRT framework, acute:chronic ratio.',
    domain: 'D2',
    priority: 'high',
    url: 'ONEDRIVE_LINK_PLACEHOLDER',
    focusAreas: ['Three metabolic pathways', 'Acute:chronic load ratio', 'Internal vs external load', 'StARRT framework', 'Return to play continuum'],
  },
  {
    id: 'candidate-handbook',
    title: 'CCFT Candidate Handbook',
    description: 'Official exam guide — domains, weights, eligibility, recertification, disciplinary process.',
    domain: 'D7',
    priority: 'critical',
    url: 'ONEDRIVE_LINK_PLACEHOLDER',
    focusAreas: ['Domain weights (D1-D7)', 'Exam format (160 Q, 3:55)', 'Eligibility paths', 'Recertification (36 CEUs)', 'Disciplinary process'],
  },
]

export const DOMAIN_WEIGHTS: Record<string, number> = {
  D1: 8,
  D2: 14,
  D3: 19,
  D4: 24,
  D5: 16,
  D6: 11,
  D7: 8,
}
