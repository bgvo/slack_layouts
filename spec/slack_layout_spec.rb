# frozen_string_literal: true

RSpec.describe SlackLayout do
  it "has a version number" do
    expect(VERSION).not_to be nil
  end

  describe ".new" do
    it "raises an error if #blocks is not implemented" do
      expect { SlackLayout.new }.to raise_error(NotImplementedError)
    end

    it "calls #build" do
      expect_any_instance_of(SlackLayout).to receive(:build)
      SlackLayout.new
    end

    it "calls #blocks" do
      expect_any_instance_of(SlackLayout).to receive(:blocks)
      SlackLayout.new
    end
  end

  describe "as a parent class" do
    it "exposes Slack::BlockKit::Layout instance to its subclasses" do
      class TestLayout < SlackLayout
        def blocks
          section { |section| }
          actions { |actions| }
        end
      end

      layout = double("Slack::BlockKit::Layout")
      allow(Slack::BlockKit).to receive(:blocks).and_yield(layout)
      expect(layout).to receive(:section)
      expect(layout).to receive(:actions)
      TestLayout.new
    end
  end

  context "when #blocks is implemented" do
    class SlackLayout::Test < SlackLayout
      def blocks
        section do |section|
          section.mrkdwn_field text: "some message"
        end
      end
    end

    describe "#as_json" do
      it "returns the layout as json" do
        expect(SlackLayout::Test.new.as_json).to eq(
          [
            { fields: [
              {
                text: "some message",
                type: "mrkdwn",
              },
            ],
              type: "section" },
          ]
        )
      end
    end
  end
end
