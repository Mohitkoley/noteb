import "package:flutter/material.dart";
import 'package:noteb/model/task.dart';

class PopupMenu extends StatelessWidget {
  final Task task;
  final VoidCallback cancelOrDeleteCallBack;
  final VoidCallback likeOrDislikeCallback;
  final VoidCallback editTaskCallback;
  final VoidCallback restoreTaskCallback;

  PopupMenu({
    Key? key,
    required this.task,
    required this.likeOrDislikeCallback,
    required this.cancelOrDeleteCallBack,
    required this.editTaskCallback,
    required this.restoreTaskCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: task.isDeleted == false
          ? (context) => [
                PopupMenuItem(
                  child: TextButton.icon(
                      onPressed: editTaskCallback,
                      icon: Icon(Icons.edit),
                      label: const Text("Edit")),
                ),
                PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: () {},
                        icon: task.isFavorite == false
                            ? Icon(Icons.bookmark_add_outlined)
                            : Icon(Icons.bookmark_remove),
                        label: task.isFavorite == false
                            ? Text("Add to \nbookmarks")
                            : Text("Remove from \nbookmarks")),
                    onTap: likeOrDislikeCallback),
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.delete),
                    label: const Text("Delete"),
                  ),
                  onTap: cancelOrDeleteCallBack,
                ),
              ]
          : (context) => [
                PopupMenuItem(
                    child: TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.restore_from_trash),
                        label: const Text("Restore")),
                    onTap: restoreTaskCallback),
                PopupMenuItem(
                  child: TextButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.delete_forever),
                    label: const Text("Delete Forver"),
                  ),
                  onTap: cancelOrDeleteCallBack,
                ),
              ],
    );
  }
}
