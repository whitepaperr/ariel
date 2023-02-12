"use strict";

import * as model from './Model.js';
import { renderTaskList } from './View.js';

function markCompleteCallback(task) {
    model.markComplete(task.id);
    renderTaskView();
}

export function renderTaskView() {
    const root = document.getElementById('tasks-root');
    root.innerHTML = '';
    const taskList = renderTaskList(markCompleteCallback);
    root.append(taskList);
}

const addTaskButton = document.getElementById('add-task-button');
addTaskButton.addEventListener('click', () => {
    const input = document.getElementById('task-input');
    const description = input.value;
    if (description) {
        model.addTask(description);
        input.value = '';
        renderTaskView();
    }
});

