/* eslint-disable @typescript-eslint/no-var-requires */
/* global describe, it, expect, jest */
import { render, screen } from "@testing-library/react";
import { Button } from "../Button";

describe("Button Component", () => {
  it("renders button with text", () => {
    render(<Button>Click me</Button>);
    expect(screen.getByRole("button", { name: /click me/i })).toBeInTheDocument();
  });

  it("handles click events", () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click me</Button>);
    const button = screen.getByRole("button", { name: /click me/i });
    button.click();
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it("disables button when disabled prop is true", () => {
    render(<Button disabled>Click me</Button>);
    const button = screen.getByRole("button", { name: /click me/i });
    expect(button).toBeDisabled();
  });

  it("shows loading state", () => {
    render(<Button isLoading>Click me</Button>);
    expect(screen.getByRole("button", { name: /loading/i })).toBeInTheDocument();
  });

  it("applies primary variant by default", () => {
    render(<Button>Click me</Button>);
    const button = screen.getByRole("button", { name: /click me/i });
    expect(button).toHaveClass("bg-[#c0392b]");
  });

  it("applies secondary variant", () => {
    render(<Button variant="secondary">Click me</Button>);
    const button = screen.getByRole("button", { name: /click me/i });
    expect(button).toHaveClass("bg-[#fdf6ee]");
  });
});
