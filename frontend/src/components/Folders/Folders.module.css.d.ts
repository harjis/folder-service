declare namespace FoldersModuleCssNamespace {
  export interface IFoldersModuleCss {
    container: string;
  }
}

declare const FoldersModuleCssModule: FoldersModuleCssNamespace.IFoldersModuleCss & {
  /** WARNING: Only available when `css-loader` is used without `style-loader` or `mini-css-extract-plugin` */
  locals: FoldersModuleCssNamespace.IFoldersModuleCss;
};

export = FoldersModuleCssModule;
