const firstNames = ["Алексей", "Матвей", "Сергей", "Андрей", "Дмитрий", "Евгений", "Антон", "Олег", "Иван", "Николай"];
const lastNames = ["Иванов", "Петров", "Сидоров", "Кузнецов", "Смирнов", "Попов", "Васильев", "Федоров", "Морозов", "Волков"];
const courses = ["Математика", "Физика", "Химия", "Биология", "История", "Экономика", "Юриспруденция", "Медицина", "Психология", "Лингвистика"];

function getRandomInt(min, max) {
    return Math.floor(Math.random() * (max - min + 1)) + min;
}

function getRandomElement(array) {
    return array[getRandomInt(0, array.length - 1)];
}

let students = [];

for (let i = 1; i <= 5; i++) {
    students.push({
        name: `${getRandomElement(firstNames)} ${getRandomElement(lastNames)}`,
        age: getRandomInt(17, 25),
        course: "Информатика",
        year: getRandomInt(1, 5),
        grades: {
            math: getRandomInt(3, 5),
            programming: getRandomInt(3, 5),
            algorithms: getRandomInt(3, 5)
        },
        isBudget: Math.random() > 0.3,
    });
}

for (let i = 6; i <= 100; i++) {
    students.push({
        name: `${getRandomElement(firstNames)} ${getRandomElement(lastNames)}`,
        age: getRandomInt(17, 25),
        course: getRandomElement(courses),
        year: getRandomInt(1, 5),
        grades: {
            math: getRandomInt(3, 5),
            programming: getRandomInt(3, 5),
            algorithms: getRandomInt(3, 5)
        },
        isBudget: Math.random() > 0.3,
    });
}

db.students.insertMany(students);
