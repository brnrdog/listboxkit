module.exports = {
  title: "listboxkit",
  tagline:
    "React hooks written in ReScript for building accessible listbox components.",
  url: "https://brnrdog.github.io",
  baseUrl: "/listboxkit/",
  onBrokenLinks: "throw",
  favicon: "img/favicon.ico",
  organizationName: "brnrdog",
  projectName: "listboxkit",
  themeConfig: {
    navbar: {
      title: "listboxkit",
      items: [
        {
          to: "docs",
          activeBasePath: "docs",
          label: "Documentation",
          position: "left",
        },
        { to: "docs/examples", label: "Examples", position: "left" },
        {
          href: "https://github.com/brnrdog/listbox",
          label: "GitHub",
          position: "right",
        },
      ],
    },
    footer: {
      style: "dark",
      links: [
        {
          title: "Docs",
          items: [
            {
              label: "Getting started",
              to: "docs",
            },
            {
              label: "Examples",
              to: "docs/examples",
            },
          ],
        },
        {
          title: "More",
          items: [
            {
              label: "GitHub",
              href: "https://github.com/brnrdog/listbox",
            },
          ],
        },
      ],
      copyright: `Copyright © ${new Date().getFullYear()}  - Built with Docusaurus.`,
    },
  },
  presets: [
    [
      "@docusaurus/preset-classic",
      {
        docs: {
          sidebarPath: require.resolve("./sidebars.js"),
          editUrl: "https://github.com/brnrdog/listbox/edit/master/docs/",
        },
        blog: {
          showReadingTime: true,
          editUrl: "https://github.com/brnrdog/listbox/edit/master/docs/blog",
        },
        theme: {
          customCss: require.resolve("./src/css/custom.css"),
        },
      },
    ],
  ],
};
