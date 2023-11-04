// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TodoList {
    uint public taskCount = 0;

    struct Task {
        uint id;
        string content;
        bool completed;
    }

    mapping(uint => Task) public tasks;

    event TaskCreated(uint id, string content, bool completed);
    event TaskCompleted(uint id, bool completed);
    event TaskRemoved(uint id);

    function createTask(string memory _content) public {
        taskCount++;
        tasks[taskCount] = Task(taskCount, _content, false);
        emit TaskCreated(taskCount, _content, false);
    }

    function toggleCompleted(uint _id) public {
        require(_id > 0 && _id <= taskCount, "Task ID is out of range.");
        Task storage task = tasks[_id];
        task.completed = !task.completed;
        emit TaskCompleted(_id, task.completed);
    }

    function removeTask(uint _id) public {
        require(_id > 0 && _id <= taskCount, "Task ID is out of range.");
        Task storage task = tasks[_id];
        emit TaskRemoved(_id);
        delete tasks[_id];

        // Move tasks up to fill the gap
        for (uint i = _id; i < taskCount; i++) {
            tasks[i] = tasks[i + 1];
        }
        taskCount--;
    }
}
