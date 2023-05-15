//
//  LittleLemonTextStyles.swift
//  littlelemon
//
//  Created by Khalid Kamil on 15/05/2023.
//

import SwiftUI

// Display Title
struct DisplayTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MarkaziText-Regular", size: 64))
            .fontWeight(.medium)
    }
}

// Subtitle - keep close to Display Title
struct Subtitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MarkaziText-Regular", size: 40))
            .fontWeight(.regular)
    }
}

// Lead Text - use for descriptive items to catch attention. e.g. home page or call to action
struct LeadText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Karla-Regular", size: 18))
            .fontWeight(.medium)
    }
}

// Section Title
struct SectionTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Karla-Regular", size: 20))
            .fontWeight(.heavy)
            .textCase(.uppercase)
    }
}

// Section Category - e.g. This Week's Specials!
struct SectionCategory: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Karla-Regular", size: 16))
            .fontWeight(.heavy)
    }
}

// Card Title
struct CardTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Karla-Regular", size: 18))
            .fontWeight(.bold)
    }
}

// NavBar - Sentence case
struct NavBar: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Karla-Regular", size: 20))
            .fontWeight(.bold)
    }
}

// Paragraph - 1.5 Line height. Max 65 characters per line
struct ParagraphText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Karla-Regular", size: 16))
            .fontWeight(.regular)
    }
}

// Highlight Text - e.g. Price
struct HighlighText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("Karla-Regular", size: 16))
            .fontWeight(.medium)
    }
}

extension View {
    func displayTitleStyle() -> some View {
        modifier(DisplayTitle())
    }
    func subtitleStyle() -> some View {
        modifier(Subtitle())
    }
    func leadTextStyle() -> some View {
        modifier(LeadText())
    }
    func sectionTitleStyle() -> some View {
        modifier(SectionTitle())
    }
    func sectionCategoryStyle() -> some View {
        modifier(SectionCategory())
    }
    func cardTitleStyle() -> some View {
        modifier(CardTitle())
    }
    func navbarStyle() -> some View {
        modifier(NavBar())
    }
    func paragraphTextStyle() -> some View {
        modifier(ParagraphText())
    }
    func highlightTextStyle() -> some View {
        modifier(HighlighText())
    }
}
