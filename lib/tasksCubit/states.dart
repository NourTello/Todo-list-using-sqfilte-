abstract class TasksStates {}

class InitialTasksState extends TasksStates {}

class CreateDataBaseState extends TasksStates {}

class OpenDataBaseState extends TasksStates {}

class InsertToDataBaseState extends TasksStates {}

class UpdateDataBaseState extends TasksStates {}

class GetFromDataBaseState extends TasksStates {}

class TasksLoadingState extends TasksStates {}

class ChangeCategoryState extends TasksStates {}

class ChangeActiveState extends TasksStates {}

class MoveToPreviousDayState extends TasksStates {}

class MoveToNextDayState extends TasksStates {}
