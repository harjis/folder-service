declare namespace FolderModuleCssNamespace {
  export interface IFolderModuleCss {
    folder: string;
    folderIcon: string;
  }
}

declare const FolderModuleCssModule: FolderModuleCssNamespace.IFolderModuleCss & {
  /** WARNING: Only available when `css-loader` is used without `style-loader` or `mini-css-extract-plugin` */
  locals: FolderModuleCssNamespace.IFolderModuleCss;
};

export = FolderModuleCssModule;
