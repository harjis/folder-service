import React from "react";

import { useFolder } from "../../hooks/useFolder";
import { Folder as FolderType } from "../../api/folders";

import styles from "./Folder.module.css";

type Props = {
  folder: FolderType;
};
export const Folder: React.FC<Props> = (props) => {
  const { children, isCollapsed, toggleCollapsed } = useFolder(props);
  return (
    <>
      <li className={styles.folder} onClick={toggleCollapsed}>
        {props.folder.id}: {props.folder.name}
      </li>
      <ul>
        {!isCollapsed &&
          children.map((child) => <Folder key={child.id} folder={child} />)}
      </ul>
    </>
  );
};
