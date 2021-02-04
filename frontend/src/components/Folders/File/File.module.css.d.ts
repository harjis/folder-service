declare namespace FileModuleCssNamespace {
  export interface IFileModuleCss {
    file: string;
  }
}

declare const FileModuleCssModule: FileModuleCssNamespace.IFileModuleCss & {
  /** WARNING: Only available when `css-loader` is used without `style-loader` or `mini-css-extract-plugin` */
  locals: FileModuleCssNamespace.IFileModuleCss;
};

export = FileModuleCssModule;
