#BT4
CREATE TABLE users (
                       id INT PRIMARY KEY,
                       fullName VARCHAR(100),
                       email VARCHAR(255),
                       password VARCHAR(255),
                       phone VARCHAR(11),
                       permission BIT,
                       status BIT
);

CREATE TABLE history (
                         id INT PRIMARY KEY,
                         user_id INT,
                         point INT,
                         examDate DATETIME,
                         FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE exams (
                       id INT PRIMARY KEY,
                       name VARCHAR(100),
                       duration INT,
                       status BIT
);

CREATE TABLE questions (
                           id INT PRIMARY KEY,
                           content VARCHAR(255),
                           exam_id INT,
                           status BIT,
                           FOREIGN KEY (exam_id) REFERENCES exams(id)
);

CREATE TABLE answer (
                        id INT PRIMARY KEY,
                        content VARCHAR(255),
                        question_id INT,
                        answerTrue BIT,
                        FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE history_detail (
                                id INT PRIMARY KEY,
                                history_id INT,
                                question_id INT,
                                result BIT,
                                FOREIGN KEY (history_id) REFERENCES history(id),
                                FOREIGN KEY (question_id) REFERENCES questions(id)
);
