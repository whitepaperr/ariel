'use strict';

import initialTasks from './task-data.js';

let currentTaskList = initialTasks.map((task, index) => {
    return { ...task, id: index + 1};
});

export function getIncompleteTasks() {
    return currentTaskList.filter(task => task.status === 'incomplete');
}

export function addTask(description) {
    const newTask = {
        description,
        status: 'incomplete',
        id: currentTaskList.length + 1
    };
    currentTaskList = [...currentTaskList, newTask];
}

export function markComplete(id) {
    currentTaskList = currentTaskList.map(task => {
        const copy = {...task};
        if (copy.id === id) {
            copy.status = 'complete';
        }
        return copy;
    });
}