-- Sample data for Monika Swift Planner
-- User ID: cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5

-- Insert sample people
INSERT INTO people (id, user_id, name, birthday, notes) VALUES
('d1e2f3a4-b5c6-7d8e-9f0a-1b2c3d4e5f6a', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'John Doe', '1990-05-15', 'Best friend from college'),
('a2b3c4d5-e6f7-8a9b-0c1d-2e3f4a5b6c7d', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'Jane Smith', '1988-11-22', 'Sister'),
('b3c4d5e6-f7a8-9b0c-1d2e-3f4a5b6c7d8e', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'Mike Johnson', '1995-03-08', 'Coworker and friend'),
('c4d5e6f7-a8b9-0c1d-2e3f-4a5b6c7d8e9f', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'Emily Brown', '1992-07-30', 'Neighbor'),
('e5f6a7b8-c9d0-1e2f-3a4b-5c6d7e8f9a0b', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'Sarah Wilson', '1985-12-14', 'Childhood friend'),
('f6a7b8c9-d0e1-2f3a-4b5c-6d7e8f9a0b1c', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'David Lee', '1993-09-25', 'Brother');

-- Insert sample events
INSERT INTO events (id, user_id, title, event_date, event_time, person_id, category, notes, reminder_enabled, reminder_days_before, recurring) VALUES
('e1a2b3c4-d5e6-7f8a-9b0c-1d2e3f4a5b6c', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'John''s Birthday', '2024-05-15', '18:00', 'd1e2f3a4-b5c6-7d8e-9f0a-1b2c3d4e5f6a', 'birthday', 'Birthday dinner at his favorite restaurant', TRUE, 7, 'yearly'),
('e2b3c4d5-e6f7-8a9b-0c1d-2e3f4a5b6c7d', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'Jane''s Birthday', '2024-11-22', '12:00', 'a2b3c4d5-e6f7-8a9b-0c1d-2e3f4a5b6c7d', 'birthday', 'Family lunch celebration', TRUE, 14, 'yearly'),
('e3c4d5e6-f7a8-9b0c-1d2e-3f4a5b6c7d8e', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'Anniversary with Sarah', '2024-06-10', '19:30', 'e5f6a7b8-c9d0-1e2f-3a4b-5c6d7e8f9a0b', 'anniversary', '10 years of friendship!', TRUE, 7, 'yearly'),
('e4d5e6f7-a8b9-0c1d-2e3f-4a5b6c7d8e9f', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'Christmas', '2024-12-25', NULL, NULL, 'holiday', 'Family gathering', TRUE, 30, 'yearly'),
('e5e6f7a8-b9c0-1d2e-3f4a-5b6c7d8e9f0a', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'Mike''s Birthday', '2024-03-08', '20:00', 'b3c4d5e6-f7a8-9b0c-1d2e-3f4a5b6c7d8e', 'birthday', 'Party at his place', TRUE, 5, 'yearly'),
('e6f7a8b9-c0d1-2e3f-4a5b-6c7d8e9f0a1b', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'Emily''s Birthday', '2024-07-30', '15:00', 'c4d5e6f7-a8b9-0c1d-2e3f-4a5b6c7d8e9f', 'birthday', 'Afternoon tea', TRUE, 10, 'yearly');

-- Insert sample gifts
INSERT INTO gifts (id, user_id, person_id, event_id, name, price, link, purchased, priority, notes) VALUES
('f1a2b3c4-d5e6-7f8a-9b0c-1d2e3f4a5b6c', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'd1e2f3a4-b5c6-7d8e-9f0a-1b2c3d4e5f6a', 'e1a2b3c4-d5e6-7f8a-9b0c-1d2e3f4a5b6c', 'Smartwatch', 299.99, 'https://amazon.com/smartwatch', FALSE, 'high', 'He mentioned wanting an Apple Watch'),
('f2b3c4d5-e6f7-8a9b-0c1d-2e3f4a5b6c7d', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'd1e2f3a4-b5c6-7d8e-9f0a-1b2c3d4e5f6a', 'e1a2b3c4-d5e6-7f8a-9b0c-1d2e3f4a5b6c', 'Book Collection', 49.99, 'https://amazon.com/books', TRUE, 'medium', 'Got the sci-fi series he loves'),
('f3c4d5e6-a7b8-9c0d-1e2f-3a4b5c6d7e8f', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'a2b3c4d5-e6f7-8a9b-0c1d-2e3f4a5b6c7d', 'e2b3c4d5-e6f7-8a9b-0c1d-2e3f4a5b6c7d', 'Necklace', 159.99, 'https://jewelry.com/necklace', FALSE, 'high', 'Silver pendant she showed me'),
('f4d5e6a7-b8c9-0d1e-2f3a-4b5c6d7e8f9a', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'b3c4d5e6-f7a8-9b0c-1d2e-3f4a5b6c7d8e', 'e5e6f7a8-b9c0-1d2e-3f4a-5b6c7d8e9f0a', 'Headphones', 199.99, 'https://amazon.com/headphones', FALSE, 'medium', 'Noise-cancelling for his commute'),
('f5e6a7b8-c9d0-1e2f-3a4b-5c6d7e8f9a0b', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'c4d5e6f7-a8b9-0c1d-2e3f-4a5b6c7d8e9f', 'e6f7a8b9-c0d1-2e3f-4a5b-6c7d8e9f0a1b', 'Tea Set', 79.99, 'https://teashop.com/set', TRUE, 'medium', 'Beautiful ceramic set'),
('f6a7b8c9-d0e1-2f3a-4b5c-6d7e8f9a0b1c', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'e5f6a7b8-c9d0-1e2f-3a4b-5c6d7e8f9a0b', 'e3c4d5e6-f7a8-9b0c-1d2e-3f4a5b6c7d8e', 'Photo Album', 39.99, 'https://photostore.com/album', FALSE, 'low', 'For our memories together'),
('f7a8b9c0-d1e2-3f4a-5b6c-7d8e9f0a1b2c', 'cf70bf3a-cc13-497c-aaab-ef4fa9cd18a5', 'f6a7b8c9-d0e1-2f3a-4b5c-6d7e8f9a0b1c', NULL, 'Gaming Console', 499.99, 'https://gaming.com/console', FALSE, 'wishlist', 'Maybe for Christmas?');

