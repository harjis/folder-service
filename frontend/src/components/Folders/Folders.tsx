import React, { Suspense } from "react";
import { useRecoilValue } from "recoil";

import { rootsAtom } from "../../atoms/folders";
import { Loading } from "../Loading/Loading";
import { Folder } from "./Folder";

type Props = {};
const Folders: React.FC<Props> = (props) => {
  const roots = useRecoilValue(rootsAtom);

  return (
    <ul>
      {roots.map((root) => (
        <li key={root.id}>
          <Folder folder={root} />
        </li>
      ))}
    </ul>
  );
};

const FoldersContainer = () => {
  return (
    <Suspense fallback={<Loading message="root folders" />}>
      <Folders />
    </Suspense>
  );
};

export default FoldersContainer;
