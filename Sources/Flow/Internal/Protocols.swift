import SwiftUI

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
@usableFromInline
protocol Subviews: RandomAccessCollection where Element: Subview, Index == Int {}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension LayoutSubviews: Subviews {}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
@usableFromInline
protocol Subview {
    var spacing: ViewSpacing { get }
    var priority: Double { get }
    func sizeThatFits(_ proposal: ProposedViewSize) -> CGSize
    func dimensions(_ proposal: ProposedViewSize) -> Dimensions
    func place(at position: CGPoint, anchor: UnitPoint, proposal: ProposedViewSize)
}

@available(iOS 16.0, macOS 13.0, tvOS 16.0, watchOS 9.0, *)
extension LayoutSubview: Subview {
    @usableFromInline
    func dimensions(_ proposal: ProposedViewSize) -> Dimensions {
        dimensions(in: proposal)
    }
}

@usableFromInline
protocol Dimensions {
    var width: CGFloat { get }
    var height: CGFloat { get }

    subscript(guide: HorizontalAlignment) -> CGFloat { get }
    subscript(guide: VerticalAlignment) -> CGFloat { get }
}
extension ViewDimensions: Dimensions {}

extension Dimensions {
    @usableFromInline
    func size(on axis: Axis) -> Size {
        Size(
            breadth: value(on: axis),
            depth: value(on: axis.perpendicular)
        )
    }

    @usableFromInline
    func value(on axis: Axis) -> CGFloat {
        switch axis {
        case .horizontal: width
        case .vertical: height
        }
    }
}
