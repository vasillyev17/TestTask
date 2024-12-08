import { Meta, StoryObj } from "@storybook/react";
import { Carousel } from "@/components/ui/carousel";
import { CustomCaruselShadcn } from "@/components/CustomCaruselShadcn";

const meta: Meta = {
  title: "Shadcn/Carousel",
  component: Carousel,
  tags: ["autodocs"],
};

export default meta;

type Story = StoryObj<typeof meta>;

export const DesktopMultiple: Story = {
  args: {
    layout: "desktop",
    amountOfSlides: 5,
  },
  render: ({ layout, amountOfSlides }) => (
    <CustomCaruselShadcn layout={layout} amountOfSlides={amountOfSlides} />
  ),
};

export const DesktopSingle: Story = {
  args: {
    layout: "desktop",
    amountOfSlides: 1,
  },
  render: ({ layout, amountOfSlides }) => (
    <CustomCaruselShadcn layout={layout} amountOfSlides={amountOfSlides} />
  ),
};

export const MobileMultiple: Story = {
  args: {
    layout: "mobile",
    amountOfSlides: 5,
  },
  render: ({ layout, amountOfSlides }) => (
    <CustomCaruselShadcn layout={layout} amountOfSlides={amountOfSlides} />
  ),
};

export const MobileSingle: Story = {
  args: {
    layout: "mobile",
    amountOfSlides: 1,
  },
  render: ({ layout, amountOfSlides }) => (
    <CustomCaruselShadcn layout={layout} amountOfSlides={amountOfSlides} />
  ),
};