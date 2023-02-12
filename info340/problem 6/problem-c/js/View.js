"use strict";

import { getIncompleteTasks } from './Model.js';

function renderSingleTask(task, markCompleteCallback) {
    const li = document.createElement('li');
    li.classList.add('list-group-item');
    li.textContent = ` ${task.description}`;

    const button = document.createElement('button');
    button.classList.add('btn', 'btn-sm', 'btn-warning');
    button.innerHTML = '<span class="material-icons-outlined">done</span>';
    button.addEventListener('click', () => {
        markCompleteCallback(task);
    });
    li.prepend(button);

    return li;
}

export function renderTaskList(markCompleteCallback) {
    const ul = document.createElement('ul');
    ul.classList.add('list-group', 'list-group-flush');
    
    const incompleteTasks = getIncompleteTasks();
    if (incompleteTasks.length === 0) {
        return document.createElement('div').textContent = 'None!';
    }

    incompleteTasks.forEach(task => {
        const li = renderSingleTask(task, markCompleteCallback);
        ul.append(li);
    });
    return ul;
}