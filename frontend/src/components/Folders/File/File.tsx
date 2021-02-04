import React from "react";

import s from "./File.module.css";

export const File: React.FC = (props) => (
  <li className={s.file}>{props.children}</li>
);
