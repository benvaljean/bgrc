import inquirer from 'inquirer';
import readline from 'readline';
import fs from 'fs';

var filename = process.env.menu;

var lines = fs.readFileSync(filename, 'utf-8')
    .split('\n')
    .filter(Boolean);

var menutitle = process.env.menu_title;

inquirer
  .prompt([
    {
      type: 'list',
      pageSize: 30,
      name: 'chosenCommand',
      message: menutitle,
      choices: lines
    },
  ])
  .then(answers => {
    fs.writeFile(process.env.menu_chosen, answers.chosenCommand, err => {
      if (err) {
        console.error(err);
      }
      // file written successfully
    });

  });

